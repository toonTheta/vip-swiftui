//
//  HealthDetailPresenter.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 2/7/2566 BE.
//  Copyright (c) 2023. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

protocol HealthDetailPresentationLogic {
    func presentDetail(response: HealthDetail.FetchDetail.Response)
}

final class HealthDetailPresenter: HealthDetailPresentationLogic {
    weak var viewController: HealthDetailDisplayActionLogic?
    private var sceneViewModel: HealthDetailSceneViewModelProtocol
    var worker: HealthDetailPresenterWorkerProtocol

    var controller: HealthDetailDisplayActionLogic? {
        return viewController
    }

    init(
        viewController: HealthDetailDisplayActionLogic,
        sceneViewModel: HealthDetailSceneViewModel,
        worker: HealthDetailPresenterWorkerProtocol = HealthDetailPresenterWorker()
    ) {
        self.viewController = viewController
        self.sceneViewModel = sceneViewModel
        self.worker = worker
    }
    
    func presentDetail(response: HealthDetail.FetchDetail.Response) {
        let recordViewModel = response.records
            .filter { $0.id != nil && $0.createdDate != nil && $0.type != nil }
            .map { ($0.id!, $0.value, $0.createdDate!, $0.type! )}
            .compactMap(HealthRecordViewModel.init)
        
        sceneViewModel.updateDetail(
            viewModel: .init(
                unit: worker.getUnit(ofType: response.recordType),
                state: .init(value: recordViewModel)
            )
        )
    }
}
