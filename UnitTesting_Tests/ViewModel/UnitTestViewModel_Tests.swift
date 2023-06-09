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
    
    func test_UnitTestViewModel_dataArray_shouldBeEmpty() {
        // Given <- no given
        // When
        let vm = UnitTestViewModel(isPremium: Bool.random())
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty) // checks arrary is empty
        XCTAssertEqual(vm.dataArray.count, 0) // checks count is 0
    }
    
    func test_UnitTestViewModel_dataArray_shouldAddItems() {
        // Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        // When
        vm.addItem(item: UUID().uuidString) // creates a random string of 36 chars | Better practice to create a function that generates a random stirnf of any size
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty) // checks arrary is not empty
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 1) // checks count is 1
        XCTAssertNotEqual(vm.dataArray.count, 0) // checks count is not 0
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestViewModel_dataArray_shouldAddItems_stress() {
        // Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        // When
        let loopCount: Int = Int.random(in: 1..<100) // loop count is random Int b/w 1 to 100
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty) // checks arrary is not empty
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount) // checks count is loop count
        XCTAssertNotEqual(vm.dataArray.count, 0) // checks count is not 0
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }

    
    func test_UnitTestViewModel_dataArray_shouldNotAddBlackString() {
        // Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        // When
        vm.addItem(item: "")
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty) // checks arrary is  empty
    }

}
