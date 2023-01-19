//
//  StocksAPIExec.swift
//  
//
//  Created by yeonBlue on 2023/01/19.
//

import Foundation
import StocksAPI

@main // 시작 지점
struct StocksAPIExec {
    
    static func main() async {
        print("Start StocksAPIExec")
        print(StocksAPI().text)
    }
}
