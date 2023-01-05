//
//  DownladingImageView.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/05.
//

import SwiftUI

struct DownladingImageView: View {
    
    @StateObject var viewModel: ImageLoadingViewModel
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        self.urlString = url
        self.imageKey = key
        _viewModel = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            }
        }
        
    }
}

struct DownladingImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownladingImageView(url: "https://via.placeholder.com/600/92c952", key: "image")
    }
}
