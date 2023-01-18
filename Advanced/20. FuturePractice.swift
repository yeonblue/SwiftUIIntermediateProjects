//
//  FuturePractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/18.
//

import SwiftUI
import Combine

// convert @escaping -> Combine
// Future 사용, RxSwift의 single과 비슷한 듯
class FuturePracticeViewModel: ObservableObject {

    @Published var title: String = "Start title"
    
    let url = URL(string: "https:://www.google.com")!
    var cancellable = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
        //getCombinePublisher()
        //    .sink { _ in
        //
        //    } receiveValue: { [weak self] returnValue in
        //        self?.title = returnValue
        //    }
        //    .store(in: &cancellable)
        
        //getEscapingClosure { [weak self] value, error in
        //    self?.title = value
        //}
        
        getFuturePublisher()
            .sink { _ in
                
            } receiveValue: { [weak self] value in
                self?.title = value
            }
            .store(in: &cancellable)
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                return "New Value"
            })
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completion: @escaping ( _ value: String, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion("New Value2", nil)
        }.resume()
    }
    
    func getFuturePublisher() -> Future<String, Error> {
        return Future { promise in
            self.getEscapingClosure { value, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(value))
                }
            }
        }
    }
    
    func doSomething(completion: @escaping (_ value: String) -> Void) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3) {
            completion("New String")
        }
    }
    
    func doSomethingInTheFuture() -> Future<String, Never> {
        Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
}

struct FuturePractice: View {
    
    @StateObject var vm: FuturePracticeViewModel = FuturePracticeViewModel()
    
    var body: some View {
        VStack {
            Text(vm.title)
        }
    }
}

struct FuturePractice_Previews: PreviewProvider {
    static var previews: some View {
        FuturePractice()
    }
}
