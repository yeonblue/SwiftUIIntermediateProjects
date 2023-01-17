//
//  NewMockDataService_Tests.swift
//  Advanced_Tests
//
//  Created by yeonBlue on 2023/01/17.
//

import XCTest
import Combine
@testable import Advanced

final class NewMockDataService_Tests: XCTestCase {

    var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        cancellable.removeAll()
    }
    
    func test_NewMockDataService_init_doesSetValuesCorrectly() {
        
        // Given
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString, UUID().uuidString]
        
        // When
        let dataService = NewMockDataService(items: items)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)
        
        // Then
        XCTAssertFalse(dataService.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertFalse(dataService3.items.isEmpty)
    }
    
    func test_NewMockDataService_downloadItemsWithEscaping_doesReturnValues() {
        
        // Given
        let dataService = NewMockDataService(items: nil)
        
        // When
        var currentItems: [String] = []
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithEscaping { items in
            currentItems = items
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(currentItems.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesReturnValues() {
        
        // Given
        let dataService = NewMockDataService(items: nil)
        
        // When
        var currentItems: [String] = []
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                        break
                }
            } receiveValue: { items in
                currentItems = items
            }
            .store(in: &cancellable)
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(currentItems.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesFail() {
        
        // Given
        let dataService = NewMockDataService(items: [])
        
        // When
        var currentItems: [String] = []
        let expectation = XCTestExpectation(description: "에러 발생")
        let expectation2 = XCTestExpectation(description: "URLError.badServerResponse 발생")
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                    case .finished:
                        XCTFail()
                    case .failure(let error):
                        expectation.fulfill()
                    
                        if let urlError = error as? URLError, urlError == URLError(.badServerResponse) {
                            expectation2.fulfill()
                        }
                }
            } receiveValue: { items in
                currentItems = items
            }
            .store(in: &cancellable)
        
        // Then
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(currentItems.count, dataService.items.count)
    }
}
