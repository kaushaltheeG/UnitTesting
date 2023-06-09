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
    
    // injection of dependency -> allows us to test the different cases of isPremium
    init(isPremium: Bool) {
        self.isPremium = isPremium
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
    
}
