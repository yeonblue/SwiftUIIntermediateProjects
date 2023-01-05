//
//  DownloadImageViewPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/05.
//

import SwiftUI

struct DownloadImageViewPractice: View {
    
    @StateObject var viewModel = DownloadImageViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.dataArray) { model in
                    DownloadingImageRow(model: model)
                }
            }
            .navigationTitle("DownloadImage")
        }
    }
}

struct DownloadImageViewPractice_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageViewPractice()
    }
}
