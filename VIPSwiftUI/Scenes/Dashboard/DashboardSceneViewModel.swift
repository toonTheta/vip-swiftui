//
//  CounterViewModel.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 30/6/2566 BE.
//

import Foundation

protocol DashboardSceneViewModelProtocol {
    func updateCategory(categoryItems: [CategoryRowViewModel])
}

class DashboardSceneViewModel: ObservableObject, DashboardSceneViewModelProtocol {
    @Published var categoryItems: [CategoryRowViewModel]
    
    init() {
        self.categoryItems = []
    }
    
    init(categoryItems: [CategoryRowViewModel]) {
        self.categoryItems = categoryItems
    }
    
    func updateCategory(categoryItems: [CategoryRowViewModel]) {
        self.categoryItems = categoryItems
    }
}
