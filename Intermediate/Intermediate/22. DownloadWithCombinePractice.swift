//
//  DownloadWithCombinePractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/03.
//

import SwiftUI
import Combine

struct PostCombineModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct DownloadWithCombinePractice: View {
    
    @MainActor @StateObject var viewModel = DownloadCombineViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    
                    Text(post.body)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct DownloadWithCombinePractice_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombinePractice()
    }
}

class DownloadCombineViewModel: ObservableObject {
    
    @Published var posts: [PostCombineModel] = []
    
    var anyCancellable = Set<AnyCancellable>()
 
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            //.subscribe(on: DispatchQueue.global(qos: .background)) 없어도 백그라운드로 동작
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostCombineModel].self, decoder: JSONDecoder())
            //.replaceError(with: [])
            //.sink(receiveValue: { [weak self] data in
            //    self?.posts = data
            //})
            .sink { completion in
                switch completion {
                    case .finished:
                        print("Finished")
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            } receiveValue: { [weak self] data in
                self?.posts = data
            }
            .store(in: &anyCancellable)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
