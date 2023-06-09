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
    
    // injection of dependency -> allows us to test the different cases of isPremium
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
}