//
//  CounterViewModel.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 30/6/2566 BE.
//

import Foundation

class DashboardSceneViewModel: ObservableObject {
    @Published var categoryItems: [CategoryRowViewModel]
    
    init() {
        self.categoryItems = []
    }
    
    init(categoryItems: [CategoryRowViewModel]) {
        self.categoryItems = categoryItems
    }
}
