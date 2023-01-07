//
//  Double.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/07.
//

import Foundation

extension Double {
    
    /// Curreny를 소수 2~6까지만 표시하도록 수정 하는 NumberFormatter
    /// ```
    /// Convert 1234.56 -> ￦1,234.56으로 변환
    /// ```
    private var currentcyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        // formatter.locale = .current
        formatter.currencyCode = "krw"
        formatter.currencySymbol = "￦"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Curreny를 소수 2~6까지만 표시하여 리턴
    /// ```
    /// Convert 1234.56 -> ￦1,234.56으로 변환
    /// ```
    /// - Returns: 원화 표시 String
    func asCurrenyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currentcyFormatter6.string(from: number) ?? "￦0.00"
    }
    
    /// 소수 2번째 까지만 표시하여 반환하는 함수
    /// ```
    /// 1.2345 -> 1.23으로 변환
    /// ```
    /// - Returns: 소수 두째짜리까지 표시하여 리턴
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// 소수를 두째짜리까지 표시하고 %표시를 추가하는 함수
    /// ```
    /// 1.2345 -> 1.23%으로 변환
    /// ```
    /// - Returns: %로 변환된 String 값
    func aspercentString() -> String {
        return asNumberString() + "%"
    }
}
