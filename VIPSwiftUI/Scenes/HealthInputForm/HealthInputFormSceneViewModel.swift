//
//  HealthInputFormSceneViewModel.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 7/7/2566 BE.
//

import SwiftUI

class HealthInputFormSceneViewModel: ObservableObject {
    @Published var dateTitle: String
    @Published var timeTitle: String
    @Published var unitTitle: String
    
    init(dateTitle: String, timeTitle: String, unitTitle: String) {
        self.dateTitle = dateTitle
        self.timeTitle = timeTitle
        self.unitTitle = unitTitle
    }
}
