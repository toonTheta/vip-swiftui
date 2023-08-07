//
//  HealthDetailSceneViewModel.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 6/7/2566 BE.
//

import Foundation
import SwiftUI

class HealthDetailSceneViewModel: ObservableObject {
    @Published var state: State
    @Published var unit: String
    
    init() {
        self.state = .empty
        self.unit = ""
    }
    
    init(state: State, unit: String) {
        self.state = state
        self.unit = unit
    }
    
    enum State {
        case empty
        case showRecords([HealthRecordViewModel])
        
        init(value: [HealthRecordViewModel]) {
            if value.isEmpty {
                self = .empty
            } else {
                self = .showRecords(value)
            }
        }
        
        @ViewBuilder
        func when(
            @ViewBuilder empty: () -> some View,
            @ViewBuilder showRecords: ([HealthRecordViewModel]) -> some View
        ) -> some View {
            switch self {
            case .empty:
                AnyView(empty())
            case let .showRecords(model):
                AnyView(showRecords(model))
            }
        }
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
