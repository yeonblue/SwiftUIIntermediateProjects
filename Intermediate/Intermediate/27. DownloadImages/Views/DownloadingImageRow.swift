//
//  DownloadingImageRow.swift
//  Intermediate
//
//  Created by yeonBlue on 2023/01/05.
//

import SwiftUI

struct DownloadingImageRow: View {
    
    let model: PhotoModel
    
    var body: some View {
        
        HStack {
            DownladingImageView(url: model.url, key: "\(model.id)")
                .frame(width: 75, height: 75)
                .padding(.vertical)
            
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                
                Text(model.url)
                    .foregroundColor(.gray)
                    .italic()
            }
        }
    }
}


struct DownloadingImageRow_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageRow(model: PhotoModel.sampleData)
            .padding()
            .previewLayout(.fixed(width: 375, height: 75))
    }
}
