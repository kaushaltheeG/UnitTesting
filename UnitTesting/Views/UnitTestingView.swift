//
//  UnitTestingView.swift
//  UnitTesting
//
//  Created by Kaushal Kumbagowdana on 6/9/23.
//

import SwiftUI

struct UnitTestingView: View {
    
    @StateObject private var vm: UnitTestViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestViewModel(isPremium: isPremium))
    }
    var body: some View {
        Text(vm.isPremium.description)
    }
}

struct UnitTestingView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingView(isPremium: true)
    }
}
