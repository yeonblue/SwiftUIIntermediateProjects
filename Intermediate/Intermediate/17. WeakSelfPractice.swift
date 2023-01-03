//
//  WeakSelfPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/02.
//

import SwiftUI

struct WeakSelfPractice: View {
    
    @AppStorage("count") var count: Int = 0
    
    init() {
        self.count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink {
                WeekSelfSecondView()
            } label: {
                Text("Navigate Second View")
            }
            .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count)")
                .font(.largeTitle)
                .padding()
                .background(.green)
                .cornerRadius(8)
                .padding()
            ,alignment: .topTrailing)
    }
}

struct WeakSelfPractice_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfPractice()
    }
}

// MARK: - WeekSelfSecondScreenViewModel
class WeekSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String? = nil
    @AppStorage("count") var count: Int = 0
    
    init() {
        getData()
        count += 1
        print("Init WeekSelfSecondScreenViewModel")
    }
    
    deinit {
        print("DeInit WeekSelfSecondScreenViewModel")
        count -= 1
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "New Data" // 지나기 전까진 deinit이 되지 않음, 따라서 weak self 사용
        }
    }
}

// MARK: - WeekSelfSecondView
struct WeekSelfSecondView: View {

    @StateObject var viewModel = WeekSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
        
            if let data = viewModel.data {
                Text(data)
            }
        }
    }
}
