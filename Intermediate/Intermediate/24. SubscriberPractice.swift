//
//  SubscriberPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/04.
//

import SwiftUI
import Combine

struct SubscriberPractice: View {
    
    @StateObject var viewModel = SubscriverViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
                .font(.largeTitle)
            
            Text("\(viewModel.textIsValid.description)")
                .font(.title)
            
            TextField("Type something here...", text: $viewModel.textFieldText)
                .frame(height: 55)
                .font(.headline)
                .foregroundColor(.gray)
                .overlay(alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(viewModel.count < 1 ? 0.0 : viewModel.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(viewModel.textIsValid ? 1.0 : 0.0)
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 16)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
                .padding()
            
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(8)
                    .padding()
                    .opacity(viewModel.showButton ? 1.0 : 0.5)
            }
            .disabled(!viewModel.showButton)
        }
    }
}

struct SubscriberPractice_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberPractice()
    }
}

class SubscriverViewModel: ObservableObject {
    
    @Published var count: Int = 0
    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.count += 1
                
                // if self.count >= 10 {
                //     for item in self.cancellables {
                //         item.cancel()
                //     }
                // }
            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // 버튼은 보통 throttle
            .map { $0.count > 3 ? true : false }
            //.weakAssign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] value in
                self?.textIsValid = value
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}


extension Publisher where Failure == Never {
    func weakAssign<T: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<T, Output>,
        on object: T
    ) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
