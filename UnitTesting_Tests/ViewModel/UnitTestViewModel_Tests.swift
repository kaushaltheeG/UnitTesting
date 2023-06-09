//
//  UnitTestViewModel_Tests.swift
//  UnitTesting_Tests
//
//  Created by Kaushal Kumbagowdana on 6/9/23.
//

import XCTest
@testable import UnitTesting // <-- importing the target App in oder for its compoennts to be tested within target testing

/*
 Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour
 
 Testing Structure: Given, When, Then
 */

final class UnitTestViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UnitTestingViewModel_isPermium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        // When
        let vm = UnitTestViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertTrue(vm.isPremium) // checks if isPremium is true
    }

}
