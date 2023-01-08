//
//  UIApplication.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/08.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
