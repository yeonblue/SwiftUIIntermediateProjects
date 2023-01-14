//
//  DependencyInjectionPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/14.
//

import SwiftUI
import Combine

// struct/class의 input을 지정해서 custom init을 수행, 동작을 다르게 하는 것
// 언제 dependency를 줄것인지 중요
// 싱글톤 패턴 대신 사용하는 것을 권장 - 싱글톤은 global, 멀티쓰레드 환경에서 위험, init을 커스텀 불가, swap(Mock)이 불가

// MARK: - PostsModel
struct PostsModel: Identifiable, Codable {
    /*
     "userId": 1,
         "id": 1,
         "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
         "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
     */
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// MARK: - ProductionDataService
class ProductionDataService: DataServiceProtocol {
    
    // static let instance = ProductionDataService()
    // private init() {}
    //let url: URL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
class MockDataService: DataServiceProtocol {
    
    let testData: [PostsModel]
    
    init(data: [PostsModel]? = nil) {
        self.testData = data ?? [
            PostsModel(userId: 11, id: 1, title: "Test Title", body: "Test Body"),
            PostsModel(userId: 22, id: 2, title: "Test Title2", body: "Test Body")
        ]
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        return Just(testData)
                .tryMap { $0 } // Just는 실패하지 않으므로 추가
                .eraseToAnyPublisher()
    }
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostsModel], Error>
}


// MARK: - DependencyInjectionViewModel
class DependencyInjectionViewModel: ObservableObject {
    
    @Published var dataArray: [PostsModel] = []
    
    let dataService: DataServiceProtocol
    var cancellable = Set<AnyCancellable>()
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] posts in
                self?.dataArray = posts
            }
            .store(in: &cancellable)
    }
}

// MARK: - DependencyInjectionPractice
struct DependencyInjectionPractice: View {
    
    @StateObject var viewModel: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        self._viewModel = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray) { post in
                    Text(post.title)
                }
            }
        }
    }
}

// MARK: - Preview
struct DependencyInjectionPractice_Previews: PreviewProvider {
    
    //static let dataServie = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    static let dataServie = MockDataService()
    static var previews: some View {
        DependencyInjectionPractice(dataService: dataServie)
    }
}

// 보통은 이런 식으로 여러 dependency를 정의해놓고 사용
class Dependencies {
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
}
