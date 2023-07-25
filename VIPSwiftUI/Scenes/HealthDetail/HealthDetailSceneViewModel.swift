//
//  HealthDetailSceneViewModel.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 6/7/2566 BE.
//

import Foundation

class HealthDetailSceneViewModel: ObservableObject {
    @Published var records: Display<[HealthRecordViewModel]> = .hidden
    @Published var unit: String
    
    init(records: Display<[HealthRecordViewModel]>, unit: String) {
        self.records = records
        self.unit = unit
    }
}

struct HealthRecordViewModel {
    let id: UUID
    let value: Double
    let stringValue: String
    let createdDate: Date
    let type: HealthRecordType
    
    init(id: UUID, value: Double, createdDate: Date, type: HealthRecordType) {
        self.id = id
        self.value = value
        self.stringValue = String(format: "%.1f", value)
        self.createdDate = createdDate
        self.type = type
    }
    
    init?(id: UUID, value: Double, createdDate: Date, type: String) {
        guard let type = HealthRecordType(rawValue: type) else { return nil }
        
        self.id = id
        self.value = value
        self.stringValue = String(format: "%.1f", value)
        self.createdDate = createdDate
        self.type = type
    }
}
