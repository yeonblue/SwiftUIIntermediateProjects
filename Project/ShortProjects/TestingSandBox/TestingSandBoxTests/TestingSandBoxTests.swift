//
//  TestingSandBoxTests.swift
//  TestingSandBoxTests
//
//  Created by yeonBlue on 2023/01/30.
//

import XCTest
@testable import TestingSandBox

// 메인 스레드는 프로그램을 시작하는 스레드이며 모든 UI 작업이 발생해야 하는 스레드. 그러나 메인큐와 메인쓰레드는 완전히 같은 것은 아님
// 메인 큐는 항상 메인 스레드에서 실행되지만(따라서 UI 작업을 수행) 다른 큐가 때때로 메인 스레드에서 실행될 수도 있습니다.
// 따라서 메인 큐에 있는 경우 확실히 메인 스레드에 있지만 메인 스레드에 있다고 해서 자동으로 메인 큐에 있다는 의미는 아닙니다.
// 다른 큐가 일시적으로 메인 스레드에서 실행 중일 수 있다.
@MainActor // main queue에서 동작을 강제
final class TestingSandBoxTests: XCTestCase {

    func test_failingThrows() throws {
        let sut = DataModel()
        try XCTAssertThrowsError(sut.goingtoFail(), "goingTofail() method should throw an Error") // async에는 사용 불가능
    }
    
    func test_failingAsyncThrows() async throws { // @MainActor가 없으면 swift는 multi-thread에서 동작,
        let sut = DataModel()
        try await XCTAssertThrowsError(await sut.goingToFail(), "goingTofail() method should throw an Error")
    }
    
    func test_flagChangesArePublished() {
        let sut = DataModel()
        var flagChangePublished = false
        
        let checker = sut.objectWillChange.sink { _ in // checker로 받지 않으면 더 이상 retain하지 않으므로 바로 사라짐
            flagChangePublished = true
        }
        _ = checker
        
        sut.flag.toggle()
        
        XCTAssertTrue(flagChangePublished, "DataModel.flag should be changed to true")
    }
    
    func test_flagChangesArePublished_usingXCTAssertSendsChangeNotification() {
        let sut = DataModel()
        XCTAssertSendsChangeNotification(sut.flag.toggle(), from: sut, "DataModel.flag should be toggled, and should trigger a change notification")
    }
    
    func test_namesAreLoaded() async {
        let sut = DataModel()
        
        let task = sut.loadData()
        await task.value // Task가 끝나기를 대기
        
        XCTAssertEqual(sut.names.count, 3, "DataModel.loadData should load 3 names.")
    }
}


func XCTAssertThrowsError<T>(_ expression: @autoclosure () async throws -> T,
                             _ message: @autoclosure () -> String = "",
                             file: StaticString = #filePath,
                             line: UInt = #line) async {
    if let _ = try? await expression() {
        XCTFail(message(), file: file, line: line) // shouldThrow므로 반드시 에러가 발생해야하므로, 여기에 도달했으면 실패
    }
}

func XCTAssertSendsChangeNotification<T, U: ObservableObject>(_ expression: @autoclosure () -> T,
                                                              from object: U,
                                                              _ message: @autoclosure () -> String = "",
                                                              file: StaticString = #filePath,
                                                              line: UInt = #line) {
    var changePublised = false
    let checker = object.objectWillChange.sink { _ in
        changePublised = true
    }
    _ = checker
    _ = expression()
    
    XCTAssertTrue(changePublised, message(), file: file, line: line)
}
