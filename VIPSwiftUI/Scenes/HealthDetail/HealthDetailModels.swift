//
//  HealthDetailModels.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 2/7/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

enum HealthDetail {

    enum FetchDetail {
        struct Request {}

        struct Response {
            let recordType: HealthRecordType
            let records: [HealthRecord]
            
            let updateWithAnimation: Bool
        }

        struct ViewModel {
            // graph
            let unit: String
            let records: Display<[HealthRecordViewModel]>
            
            let updateWithAnimation: Bool
        }
    }
    
    enum AddDetail {
        struct Request {
            let value: Double
            let date: Date
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            let records: [HealthRecordViewModel]
        }
    }
    
    enum RemoveDetail {
        struct Request {
            let indexSet: IndexSet
        }
        
        struct Response {  
        }
        
        struct ViewModel {
        }
    }
}
