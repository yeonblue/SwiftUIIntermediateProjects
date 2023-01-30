//
//  LazyPractice.swift
//  PerformanceSandBox
//
//  Created by yeonBlue on 2023/01/30.
//

import Foundation

//
// let names = ["Henry", "James"]
// let result = names.map(uppercase).map(reverse).map(count)
// let lazyReslut. Array(names.lazy.map(uppercase).map(reverse).map(count))

// lazy를 사용하면 한 개의 값을 얻고 그다음 것을 반복하는 방식으로 진행되어 좀 더 최적화가 가능
// lazy를 사용하면 LazyMapSequence가 나오므로 Array로 cast
// lazy를 사용해서 result[2]를 얻으면 필요한 것만 얻음
