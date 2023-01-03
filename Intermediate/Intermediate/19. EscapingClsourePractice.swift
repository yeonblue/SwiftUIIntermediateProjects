//
//  EscapingClsourePractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/03.
//

import SwiftUI

struct EscapingClsourePractice: View {
    
    @StateObject var viewModel = EscapingViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                viewModel.getData()
            }
    }
}

struct EscapingClsourePractice_Previews: PreviewProvider {
    static var previews: some View {
        EscapingClsourePractice()
    }
}

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello, world!"
    
    func getData() {
        downloadData2 { [weak self] data in
            self?.text = data
        }
        
        downloadData3 { [weak self] data in
            self?.text = data // viewModel이 deinit 되어야 한다면 weak self 사용
        }
        
        downloadData4 { [weak self] data in
            self?.text = data.data // viewModel이 deinit 되어야 한다면 weak self 사용
        }
        
        downloadData5 { [weak self] data in
            self?.text = data.data // viewModel이 deinit 되어야 한다면 weak self 사용
        }
    }
    
    func downloadData() -> String {
        return "New Data"
    }
    
    func downloadData2(completion: (_ data: String) -> ()) {
        completion("New Data2")
    }
    
    func downloadData3(completion: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion("New Data3")
        }
    }
    
    func downloadData4(completion: @escaping (_ data: DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(DownloadResult(data: "New Data4"))
        }
    }
    
    func downloadData5(completion: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completion(DownloadResult(data: "New Data5"))
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()
