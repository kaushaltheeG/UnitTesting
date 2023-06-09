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
                   test_[struct or class]_ variable or function]_[expected result]
 
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
    
    func test_UnitTestingViewModel_isPermium_shouldBeFalse() {
        // Given
        let userIsPremium: Bool = false
        // When
        let vm = UnitTestViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertFalse(vm.isPremium) // checks if isPremium is false
    }
    
    func test_UnitTestingViewModel_isPermium_shouldBeInjectedValue() {
        // Given
        let userIsPremium: Bool = Bool.random() // can be true or false
        // When
        let vm = UnitTestViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium) // checks if isPremium is set up properly
    }
    
    func test_UnitTestingViewModel_isPermium_shouldBeInjectedValue_stress() {
        // stress test that will loop 10 times to make sure true and false appear
        // covers all the edges cases when using randome
        for _ in 0..<10 {
            // Given
            let userIsPremium: Bool = Bool.random() // can be true or false
            // When
            let vm = UnitTestViewModel(isPremium: userIsPremium)
            // Then
            XCTAssertEqual(vm.isPremium, userIsPremium) // checks if isPremium is set up properly
        }
    }

}
