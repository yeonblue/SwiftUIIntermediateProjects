//
//  AdvancedCombinePractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/18.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
    // @Published var basicPublisher: String = "first publish" // 구독하자마자 바로 방출이 됨, 원하지 않으면 PassthroughSubject를 사용
    let currentValueSubject = CurrentValueSubject<Int, Error>(-1)
    let passthroughtSubject = PassthroughSubject<Int, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        
        let items: [Int] = Array(0..<11)
        
        for i in items.indices {
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + Double(i)) { [weak self] in
                self?.passthroughtSubject.send(items[i])
                
                if (i > 4 && i < 8) {
                    self?.boolPublisher.send(true)
                    self?.intPublisher.send(999)
                } else {
                    self?.boolPublisher.send(false)
                }
                
                if i == items.indices.last { // last는 끝났음을 알려줘야 함
                    self?.passthroughtSubject.send(completion: .finished)
                }
            }
        }
    }
}

class AdvancedCombineViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var dataBool: [Bool] = []
    @Published var error: String = ""
    let dataService = AdvancedCombineDataService()
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    private func addSubscriber() {
        //dataService.passthroughtSubject
            // Sequence
            //.first(where: { $0 > 4 })
            //.tryFirst(where: { int in
            //    if int == 3 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return int > 3
            //})
            //.last() // last where, tryLast도 존재
            //.dropFirst(2) // rxswift에서는 skip, take
            //.drop(while: { $0 < 5 }) // 조건을 만족하는 동안 계속 drop, tryDrop도 존재
            //.prefix(5) // prefix while, tryPrefix
            //.output(at: 3) // 특정 index element만 추출
            //.output(in: 2..<5)
        
            // Mathmatic
            //.max() // finish를 대기, tryMax
            //.max(by: { int1, int2 in
            //    return int1 < int2
            //})
            //.min() // tryMin, min(by:)
        
            // Filter, Reducing
            //.map, tryMap ...
            //.compactMap(<#T##transform: (Int) -> T?##(Int) -> T?#>) nil을 무시, tryCompactMap
            //.filter { $0 % 2 == 0 } // tryFitler
            //.removeDuplicates()
            //.removeDuplicates(by: { int1, int2 in
            //    return int1 == int2
            //})
            //.replaceNil(with: 5)
            //.replaceError(with: 2) // 하지만 이후 추가 데이터가 방출되지는 않음
            //.replaceEmpty(with: 3) // 빈 array일 경우
            //.scan(0, { sumValue, newValue in // tryScan
            //    return sumValue + newValue
            //})
            //.reduce(0, +) // 계산하는 동안은 방출되지 않음, 최종 결과만 보여 줌, scan과의 차이점
            //.collect(3)
            //.map({ arr -> String in
            //    let strArr = arr.map { String($0) }
            //    return strArr.joined(separator: " ")
            //})
            //.allSatisfy({ $0 > 3 }) // finish가 되야 결과를 얻음
        
            // Timing
            //.debounce(for: 1.5, scheduler: DispatchQueue.main) // textField 등에서 사용
            //.delay(for: 2, scheduler: DispatchQueue.main)
            //.measureInterval(using: DispatchQueue.main) // debug에 사용할 수 있을 듯
            //.map({ stride in
            //    return "\(stride.timeInterval)"
            //})
            //.throttle(for: 3, scheduler: DispatchQueue.main, latest: true) // 버튼 연타 방지 등 사용
            //.retry(3) // redownload 등
            //.timeout(0.75, scheduler: DispatchQueue.main) // 정해진 기간동안 응답이 없으면 terminate
        
            // Multiple Publisher / Subscrber
            //.combineLatest(dataService.boolPublisher, dataService.intPublisher) // 모두 값이 1개라도 있어야 시작
            //.compactMap({ (int1, bool, int2) in
            //    if bool {
            //        return String(int1)
            //    }
            //
            //    return "n/a"
            //})
            //.merge(with: dataService.intPublisher)
            //.zip(dataService.boolPublisher, dataService.intPublisher) // 값을 한 개씩 결합, 3개만 나올 것
            //.map({ int, bool, int2 in
            //    return String(int) + bool.description + String(int2)
            //})
            //.tryMap({ _ in throw URLError(.badServerResponse) })
            //.catch({ error in // 에러가 발생했을 경우 Publiser로 변환
            //    return self.dataService.intPublisher
            //})
        
        let sharedPublisher = dataService.passthroughtSubject
            .dropFirst(3)
            .share() // multiconnect + autoconnect, 바로 시작하길 원하지 않은다면 multiconnect, connect 사용
        
        sharedPublisher
            .map { String($0) }
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error): // Never라 실패할 경우는 없음
                        self.error = error.localizedDescription
                        break
                }
            } receiveValue: { [weak self] data in
                self?.data.append(data)
            }
            .store(in: &cancellable)
        
        sharedPublisher
            .map { $0 > 5 ? true : false }
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error): // Never라 실패할 경우는 없음
                        self.error = error.localizedDescription
                        break
                }
            } receiveValue: { [weak self] data in
                self?.dataBool.append(data)
            }
            .store(in: &cancellable)
    }
}

struct AdvancedCombinePractice: View {
    
    @StateObject private var vm = AdvancedCombineViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) { data in
                        Text(data)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                }
                
                VStack {
                    ForEach(vm.dataBool, id: \.self) { data in
                        Text(data.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                }
            }
        }
    }
}

struct AdvancedCombinePractice_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombinePractice()
    }
}
