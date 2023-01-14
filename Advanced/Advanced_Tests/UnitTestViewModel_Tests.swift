//
//  UnitTestViewModel_Tests.swift
//  Advanced_Tests
//
//  Created by yeonBlue on 2023/01/14.
//

import XCTest
@testable import Advanced

// Naming:
// test로 반드시 시작
// test_UnitOfWork_StateUnderTest_ExpectedBehavior
// test_[struct or class]_[variable or function]_[expected value or result]

// Testing Structure: Given, When, Then

final class UnitTestViewModel_Tests: XCTestCase {

    var viewModel: UnitTestViewModel?
    
    override func setUpWithError() throws {
        viewModel = UnitTestViewModel(isPremium: true) // 매 테스트 마다 초기화 함수, 아래의 경우처럼 매번 초기화 할 필요는 없음
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeTrue() {
        
        // Given
        let userIsPremium: Bool = true
        
        // When
        let viewModel = UnitTestViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(viewModel.isPremium)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeFalse() {
        
        // Given
        let userIsPremium: Bool = false
        
        // When
        let viewModel = UnitTestViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertFalse(viewModel.isPremium)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeInjectedValue() {
        
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // When
        let viewModel = UnitTestViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(viewModel.isPremium, userIsPremium)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // When
            let viewModel = UnitTestViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(viewModel.isPremium, userIsPremium)
        }
    }
    
    func test_UnitTestViewModel_dataArray_shouldBeEmpty() {
        
        // Given
        
        // When
        let viewModel = UnitTestViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(viewModel.dataArray.isEmpty)
        XCTAssertEqual(viewModel.dataArray.count, 0)
    }
    
    func test_UnitTestViewModel_dataArray_shouldAddItem() {
        
        // Given
        let viewModel = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 0...50)
        
        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertTrue(!viewModel.dataArray.isEmpty)
        XCTAssertFalse(viewModel.dataArray.isEmpty)
        XCTAssertEqual(viewModel.dataArray.count, loopCount)
        XCTAssertNotEqual(viewModel.dataArray.count, 0)
        XCTAssertGreaterThan(viewModel.dataArray.count, 0)
        // XCTAssertGreaterThanOrEqual(<#T##expression1: Comparable##Comparable#>, <#T##expression2: Comparable##Comparable#>)
        // XCTAssertLessThan(<#T##expression1: Comparable##Comparable#>, <#T##expression2: Comparable##Comparable#>)
        // XCTAssertLessThanOrEqual(<#T##expression1: Comparable##Comparable#>, <#T##expression2: Comparable##Comparable#>)
    }
    
    func test_UnitTestViewModel_dataArray_shouldNotAddBlankItem() {
        
        // Given
        let viewModel = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        viewModel.addItem(item: "")
        
        // Then
        XCTAssertTrue(viewModel.dataArray.isEmpty)
    }
    
    func test_UnitTestViewModel_selectedItem_shouldStartAsNil() {
        
        // Given
        
        // When
        let viewModel = UnitTestViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(viewModel.selectedItem == nil)
        XCTAssertNil(viewModel.selectedItem)
    }
    
    func test_UnitTestViewModel_selectedItem_shouldBeNilWhenInvalidItem() {
        
        // Given
        let viewModel = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        viewModel.selectItem(item: UUID().uuidString)
        
        // Then
        XCTAssertTrue(viewModel.selectedItem == nil)
        XCTAssertNil(viewModel.selectedItem)
    }
    
    func test_UnitTestViewModel_selectedItem_shouldBeSelected() {
        
        // Given
        let viewModel = UnitTestViewModel(isPremium: Bool.random())
        let newItem = UUID().uuidString
        viewModel.addItem(item: newItem)
        
        // When
        viewModel.selectItem(item: newItem)
        
        // Then
        XCTAssertTrue(viewModel.selectedItem != nil)
        XCTAssertNotNil(viewModel.selectedItem)
    }
    
    func test_UnitTestViewModel_selectedItem_shouldBeNilWhenSelecteingInvalidItem() {
        
        // Given
        let viewModel = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        // 1. select valid item
        let newItem = UUID().uuidString
        viewModel.addItem(item: newItem)
        viewModel.selectItem(item: newItem)
        
        // 2. select invalid item
        viewModel.selectItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(viewModel.selectedItem)
    }
    
    func test_UnitTestViewModel_selectedItem_shouldBeNilWhenSelecteingInvalidItem_stress() {
        
        // Given
        let viewModel = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<30)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            viewModel.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        viewModel.selectItem(item: randomItem)
        
        // Then
        XCTAssertNotNil(viewModel.selectedItem)
        XCTAssertEqual(viewModel.selectedItem, randomItem)
    }
    
    func test_UnitTestViewModel_saveItem_shouldThrowError_itemNotFound() {
        
        // Given
        let viewModel = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<30)

        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertThrowsError(try viewModel.saveItem(item: UUID().uuidString))
        
        XCTAssertThrowsError(try viewModel.saveItem(item: UUID().uuidString),
                             "Should throw itemNotFound") { error in
            let returnedError = error as? DataError
            XCTAssertEqual(returnedError, DataError.itemNotFound)
        }
    }
    
    func test_UnitTestViewModel_saveItem_shouldThrowError_noData() {
        
        // Given
        let viewModel = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<30)

        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertThrowsError(try viewModel.saveItem(item: ""))
        
        XCTAssertThrowsError(try viewModel.saveItem(item: ""),
                             "Should throw no data error") { error in
            let returnedError = error as? DataError
            XCTAssertEqual(returnedError, DataError.noData)
        }
        
        do {
            try viewModel.saveItem(item: "")
        } catch let error {
            let returnedError = error as? DataError
            XCTAssertEqual(returnedError, DataError.noData)
        }
    }
    
    func test_UnitTestViewModel_saveItem_shouldThrowError_shouldSaveItem() {
        
        // Given
        let viewModel = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        let loopCount = Int.random(in: 1..<30)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            viewModel.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        viewModel.selectItem(item: randomItem)
        XCTAssertFalse(viewModel.dataArray.isEmpty)
        
        // Then
        XCTAssertNoThrow(try viewModel.saveItem(item: randomItem))
        
        do {
            try viewModel.saveItem(item: "")
        } catch {
            XCTFail() // 에러가 발생하면 안되므로
        }
    }
    
    func test_setup_test() {
        guard let viewModel = viewModel else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(viewModel.dataArray.isEmpty)
    }
}
