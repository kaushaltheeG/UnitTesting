//
//  UnitTestViewModel.swift
//  UnitTesting
//
//  Created by Kaushal Kumbagowdana on 6/9/23.
//

import Foundation
import Combine

class UnitTestViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    let dataService: DataServiceProtocol
    var cancelables = Set<AnyCancellable>()
    
    // injection of dependency -> allows us to test the different cases of isPremium
    init(isPremium: Bool, dataService: DataServiceProtocol = MockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return } // doesn't add item is strign is empty
        self.dataArray.append(item)
    }
    
    func selectedItem(item: String) {
        // assigning slectedItem var the x var only if input item is within dataArray
        if let x = dataArray.first(where: { $0 == item}) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    // save item or may thorw the item
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            // throws if item is empty string
            throw DataError.noData
        }
        
        if let x = dataArray.first(where: { $0 == item }) {
            print("Save item here \(x)")
        } else {
            throw DataError.dataNotFound
        }
    }
    
    // use [weak self] with async code and self? will be need
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { [weak self] returnedItem in
            self?.dataArray = returnedItem
        }
    }
    
    func downloadWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] returnedItem in
                self?.dataArray = returnedItem
            })
            .store(in: &cancelables)
    }
    
}

extension UnitTestViewModel {
    // custom errors for this vm
    enum DataError: LocalizedError {
        case noData
        case dataNotFound
    }
}
