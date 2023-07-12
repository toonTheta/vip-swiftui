//
//  HealthDetailInteractor.swift
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

protocol HealthDetailBusinessLogic {
    func fetchDetail(request: HealthDetail.FetchDetail.Request)
    func addDetail(request: HealthDetail.AddDetail.Request)
}

protocol HealthDetailDataStore {
    var recordType: HealthRecordType! { get }
}

final class HealthDetailInteractor: HealthDetailBusinessLogic, HealthDetailDataStore {
    var presenter: HealthDetailPresentationLogic
    private var worker: HealthDetailWorkerProtocol
    
    private(set) var recordType: HealthRecordType!
    private let healthService: HealthServiceProtocol

    init(
        worker: HealthDetailWorkerProtocol = HealthDetailWorker(),
        presenter: HealthDetailPresentationLogic,
        recordType: HealthRecordType,
        healthService: HealthServiceProtocol
    ) {
        self.worker = worker
        self.presenter = presenter
        self.recordType = recordType
        self.healthService = healthService
    }
    
    func fetchDetail(request: HealthDetail.FetchDetail.Request) {
        refreshDetail()
    }
    
    func addDetail(request: HealthDetail.AddDetail.Request) {
        healthService.createHealthRecord(
            id: UUID(),
            value: request.value,
            createdDate: Date(),
            type: recordType
        )
        
        refreshDetail()
    }
    
    func refreshDetail() {
        let result = healthService.fetchHealthRecords(ofType: recordType)
        
        switch result {
        case let .success(records):
            presenter.presentDetail(response: .init(
                recordType: recordType,
                records: records
            ))
        case .failure(_):
            // TODO: Handle error
            break
        }
    }
}
