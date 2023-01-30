//
//  DeboucedObservedObject.swift
//  PerformanceSandBox
//
//  Created by yeonBlue on 2023/01/29.
//

import SwiftUI
import Combine

@propertyWrapper @dynamicMemberLookup
class DeboucedObservedObject<Wrapped: ObservableObject>: ObservableObject {
    
    public var wrappedValue: Wrapped
    private var subscrtiption: AnyCancellable?
    
    init(wrappedValue: Wrapped, delay: Double = 1.0) {
        self.wrappedValue = wrappedValue
        
        subscrtiption = wrappedValue.objectWillChange // watch the thing inside for changes
            .debounce(for: .seconds(delay), scheduler: DispatchQueue.main) // wrappedValue를 debounce를 줘서 관찰
            .sink(receiveValue: { [weak self] _ in
                self?.objectWillChange.send() // 값이 오면 값이 변했음을 방출
            })
    }
    // @dynamicMemberLookup with using Keypath
    subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<Wrapped, Value>) -> Value {
        get {
            wrappedValue[keyPath: keyPath]
        } set {
            wrappedValue[keyPath: keyPath] = newValue
        }
    }
}
