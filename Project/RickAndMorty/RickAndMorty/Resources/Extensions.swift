//
//  Extensions.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/25.
//

import UIKit

extension UIView {
    
    /// 여러 뷰들을 한번에 addSubView하기 위한 함수
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}

