//
//  DownloadPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/03.
//

import SwiftUI

struct DownloadPractice: View {
    
    @StateObject var viewModel = DownloadViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                VStack {
                    Text(post.title)
                        .font(.headline)
                    
                    Text(post.body)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct DownloadPractice_Previews: PreviewProvider {
    static var previews: some View {
        DownloadPractice()
    }
}

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadViewModel: ObservableObject {
    
    @MainActor @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(url: url) { data in
            
            print("Download Completed!")
            guard let data = data,
                  let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else {
                print("No data returned")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.posts.append(contentsOf: newPosts)
            }
        }
    }
    
    func downloadData(url: URL, completion: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(nil)
                return
            }
            
            completion(data)
        }.resume()
    }
}
