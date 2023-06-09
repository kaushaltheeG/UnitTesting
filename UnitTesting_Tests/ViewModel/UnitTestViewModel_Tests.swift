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
    
    var viewModel: UnitTestViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil 
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

    
    func test_UnitTestViewModel_dataArray_shouldNotAddBlankString() {
        // Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        // When
        vm.addItem(item: "")
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty) // checks arrary is  empty
    }
    
    func test_UnitTestViewModel_dataArray_shouldNotAddBlankString2() {
        // Given
            // uses the vm from the setUpWithError
        guard let vm = viewModel else {
            XCTFail() // test fails
            return
        }
        // When
        vm.addItem(item: "")
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty) // checks arrary is  empty
    }
    
    func test_UnitTestViewModel_selectedItem_shouldStartAsNil() {
        // Given
        // When
        let vm = UnitTestViewModel(isPremium: Bool.random())
        // Then
        XCTAssertTrue(vm.selectedItem == nil) // checks is nil
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        // When
        // select valid item
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectedItem(item: newItem)
        
        // select bad item after
        vm.selectedItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestViewModel_selectedItem_shouldBeSelected() {
        // Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        // When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectedItem(item: newItem)
        
        // Then
        XCTAssertEqual(vm.selectedItem, newItem)
        XCTAssertNotNil(vm.selectedItem)
    }
    
    // a strong test
    func test_UnitTestViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        // When
        let loopCount: Int = Int.random(in: 1..<100)
        // local item array
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        // retrieve random item from local array for selectedItem()
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectedItem(item: randomItem)
        XCTAssertFalse(randomItem.isEmpty) // fail safe
        // Then
        XCTAssertEqual(vm.selectedItem, randomItem)
        XCTAssertNotNil(vm.selectedItem)
    }
    
    func test_UnitTestViewModel_saveItem_shouldThrowError_noData() {
        // Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
        }
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: ""))
        XCTAssertThrowsError(try vm.saveItem(item: ""), "Should throw Item Not Found error!") { error in
            let returnedError = error as? UnitTestViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestViewModel.DataError.noData)
        }
    }
    
    func test_UnitTestViewModel_saveItem_shouldThrowError_dataNotFound() {
        // Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
        }
        
        // Then
            // Do block does the same thing as noData test but in a clean way
        do {
            try vm.saveItem(item: UUID().uuidString)
        } catch let error {
            let returnedError = error as? UnitTestViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestViewModel.DataError.dataNotFound)
        }
    }
    
    func test_UnitTestViewModel_saveItem_shouldSaveItem() {
        // Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1..<100)
        // local item array
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        // retrieve random item from local array for selectedItem()
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty) // fail safe
        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem)) // doesn't throw an error
        
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }


}
