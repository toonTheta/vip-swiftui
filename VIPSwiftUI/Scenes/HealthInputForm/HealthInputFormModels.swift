//
//  HealthInputFormModels.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 7/7/2566 BE.
//  Copyright (c) 2023. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

enum HealthInputForm {
    
    enum SceneOption {
        case adding(recordType: HealthRecordType)
        case editing(record: HealthRecord)
    }
    
    enum PrepareData {
        struct Request {}

        struct Response {
            let date: Date
            let value: Double?
            let recordType: HealthRecordType
            
            let submitButtonEnabled: Bool
            let deleteButtonEnabled: Bool
        }

        struct ViewModel {
            let dateTitle: String
            let timeTitle: String
            let unitTitle: String
            
            let dateValue: Date
            let textInputValue: String
            
            let submitButtonDisabled: Bool
            let deleteButtonDisplay: Display<String>
        }
    }
    
    enum ProceedTextInput {
        struct Request {
            let text: String
        }

        struct Response {
            let submitButtonDisabled: Bool
        }

        struct ViewModel {
            let submitButtonDisabled: Bool
        }
    }
    
    enum ProceedDateInput {
        struct Request {
            let date: Date
        }
    }
}
