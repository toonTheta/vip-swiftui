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
    
    @Published var dateTimeValue: Date
    @Published var textInputValue: String
    @Published var saveButtonDisabled: Bool
    @Published var deleteButtonDisplay: Display<String>
    
    init() {
        self.dateTitle = ""
        self.timeTitle = ""
        self.unitTitle = ""
        
        self.dateTimeValue = Date()
        self.textInputValue = ""
        self.saveButtonDisabled = true
        self.deleteButtonDisplay = .hidden
    }
    
    init(
        dateTitle: String,
        timeTitle: String,
        unitTitle: String,
        dateTimeValue: Date,
        textValue: String,
        saveButtonDisabled: Bool,
        deleteButtonTitleDisplay: Display<String>
    ) {
        self.dateTitle = dateTitle
        self.timeTitle = timeTitle
        self.unitTitle = unitTitle
        
        self.dateTimeValue = dateTimeValue
        self.textInputValue = textValue
        self.saveButtonDisabled = saveButtonDisabled
        self.deleteButtonDisplay = deleteButtonTitleDisplay
    }
    
    func updatePreparedData(viewModel: HealthInputForm.PrepareData.ViewModel) {
        self.dateTitle = viewModel.dateTitle
        self.timeTitle = viewModel.timeTitle
        self.unitTitle = viewModel.unitTitle
        
        self.dateTimeValue = viewModel.dateValue
        self.textInputValue = viewModel.textInputValue
        self.saveButtonDisabled = viewModel.submitButtonDisabled
        self.deleteButtonDisplay = viewModel.deleteButtonDisplay
    }
}
