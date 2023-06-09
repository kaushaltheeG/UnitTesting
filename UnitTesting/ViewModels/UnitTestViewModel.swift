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
    
    // injection of dependency -> allows us to test the different cases of isPremium
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return } // doesn't add item is strign is empty
        self.dataArray.append(item)
    }
    
}
