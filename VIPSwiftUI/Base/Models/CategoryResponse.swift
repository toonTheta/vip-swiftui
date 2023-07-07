//
//  CategoryResponse.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 2/7/2566 BE.
//

import Foundation

enum HealthRecordType: String, Hashable {
    case bodyMassIndex = "body_mass_index"
    case bodyFatPercentage = "body_fat_percentage"
    case weight = "weight"
    case height = "height"
}

struct CategoryResponse {
    let value: String?
    let lastUpdate: Date?
    let type: HealthRecordType
}
