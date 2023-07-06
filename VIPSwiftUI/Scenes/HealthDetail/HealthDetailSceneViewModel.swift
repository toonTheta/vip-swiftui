//
//  HealthDetailSceneViewModel.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 6/7/2566 BE.
//

import Foundation

class HealthDetailSceneViewModel: ObservableObject {
    @Published var records: [HealthRecord] = []
    
    init(records: [HealthRecord]) {
        self.records = records
    }
}
