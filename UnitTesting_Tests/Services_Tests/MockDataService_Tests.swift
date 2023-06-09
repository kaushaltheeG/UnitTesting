//
//  MockDataService_Tests.swift
//  UnitTesting_Tests
//
//  Created by Kaushal Kumbagowdana on 6/9/23.
//

import XCTest
@testable import UnitTesting
import Combine

final class MockDataService_Tests: XCTestCase {
    
    var cancelables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MockDataService_init_doesSetValuesCorrectly() {
        // Given
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString]
        
        // When
        let dataService = MockDataService(items: items)
        let dataService2 = MockDataService(items: items2)
        let dataService3 = MockDataService(items: items3)
        
        // Then
        XCTAssertFalse(dataService.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
    
    func test_MockDataService_downloadItemsWithEscaping_doesReturnValues() {
        // Given
        let dataService = MockDataService(items: nil)
        
        // When
        var items: [String]? = []
        let expectation = XCTestExpectation(description: "should return after 3 seconds")
        
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill() // required for async tests
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(dataService.items.count, items?.count)
    }
    
    func test_MockDataService_downloadItemsWithCombine_doesReturnValues() {
        // Given
        let dataService = MockDataService(items: nil)
        
        // When
        var items: [String]? = []
        let expectation = XCTestExpectation(description: "should return after 1 seconds")
        
        dataService.downloadItemsWithCombine()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill() // fullfil when complete
                case .failure:
                    XCTFail("Failed subscription") // fail test if failure found
                    break
                }
            }, receiveValue: { returnedItems in
                items = returnedItems
            })
            .store(in: &cancelables)
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(dataService.items.count, items?.count)
    }
    
    func test_MockDataService_downloadItemsWithCombine_doesFail() {
        // Given
        let dataService = MockDataService(items: []) // fails when empty array
        
        // When
        var items: [String]? = []
        let expectation = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw URLError.badServerResponse")
        
        dataService.downloadItemsWithCombine()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Failed to test failure of subscription")
                case .failure(let error):
                    expectation.fulfill() // purposely caused failure
                    
//                    let urlError = error as? URLError
//                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    // checks if error is URLError type and equal to badServerResponse
                    if error as? URLError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            }, receiveValue: { returnedItems in
                items = returnedItems
            })
            .store(in: &cancelables)
        
        // Then
        // wait: required when testing async code; expects all the expectations within the for: dependency array to be completed
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(dataService.items.count, items?.count)
    }


}
