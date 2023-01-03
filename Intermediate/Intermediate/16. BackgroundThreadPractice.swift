//
//  BackgroundThreadPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/02.
//

import SwiftUI

struct BackgroundThreadPractice: View {
    
    // MARK: - Properties
    @StateObject var viewModel = BackgroundViewModel()
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                
                Button {
                    viewModel.fetchData()
                } label: {
                    Text("Load Data")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Capsule().fill(.blue))
                }
                
                Spacer(minLength: 16)
                
                ForEach(viewModel.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadPractice_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadPractice()
    }
}

// MARK: - ViewModel
class BackgroundViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            
            print(Thread.isMainThread, Thread.current)
            let newData = self.downloadData() // 별도 Thread라 reference를 줘야 함
            
            DispatchQueue.main.async {
                print(Thread.isMainThread, Thread.current)
                self.dataArray = newData
            }
        }
    }
    
    func downloadData() -> [String] {
        var data: [String] = []
        
        for i in 0..<100 {
            data.append("\(i)")
            print(i)
        }
        
        return data
    }
}
