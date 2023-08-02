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
    
    @Published var saveButtonDisabled: Bool
    @Published var deleteButtonDisplay: Display<String>
    
    init(
        dateTitle: String,
        timeTitle: String,
        unitTitle: String,
        saveButtonDisabled: Bool,
        deleteButtonTitleDisplay: Display<String>
    ) {
        self.dateTitle = dateTitle
        self.timeTitle = timeTitle
        self.unitTitle = unitTitle
        self.saveButtonDisabled = saveButtonDisabled
        self.deleteButtonDisplay = deleteButtonTitleDisplay
    }
}
