//
//  CategoryResponse.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 2/7/2566 BE.
//

import Foundation

enum CategoryType: Hashable {
    case bodyMassIndex
    case bodyFatPercentage
    case weight
    case height
}

struct CategoryResponse {
    let value: String?
    let lastUpdate: Date?
    let type: CategoryType
}
