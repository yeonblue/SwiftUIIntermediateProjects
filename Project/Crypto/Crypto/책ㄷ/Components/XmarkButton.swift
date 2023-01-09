//
//  XmarkButton.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/09.
//

import SwiftUI

struct XmarkButton: View {
    
    @Environment(\.presentationMode) var presentaionMode // dismiss는 15.0부터 사용 가능
    
    var body: some View {
        Button {
            presentaionMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

struct XmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButton()
    }
}
