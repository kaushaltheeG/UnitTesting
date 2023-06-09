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
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
}
