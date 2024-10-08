//
//  HealthInputFormPresenter.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 7/7/2566 BE.
//  Copyright (c) 2023. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

protocol HealthInputFormPresentationLogic {
    func presentPreparedData(response: HealthInputForm.PrepareData.Response)
    func presentProceedTextInput(response: HealthInputForm.ProceedTextInput.Response)
}

final class HealthInputFormPresenter: HealthInputFormPresentationLogic {
    weak var viewController: HealthInputFormDisplayActionLogic?
    var worker: HealthInputFormPresenterWorkerProtocol
    private var sceneViewModel: HealthInputFormSceneViewModelProtocol

    var controller: HealthInputFormDisplayActionLogic? {
        return viewController
    }

    init(
        viewController: HealthInputFormDisplayActionLogic,
        sceneViewModel: HealthInputFormSceneViewModelProtocol,
        worker: HealthInputFormPresenterWorkerProtocol = HealthInputFormPresenterWorker()
    ) {
        self.viewController = viewController
        self.sceneViewModel = sceneViewModel
        self.worker = worker
    }
    
    func presentPreparedData(response: HealthInputForm.PrepareData.Response) {
        
        sceneViewModel.updatePreparedData(viewModel: .init(
            dateTitle: "Date",
            timeTitle: "Time",
            unitTitle: worker.mapUnitLabel(recordType: response.recordType),
            dateValue: response.date,
            textInputValue: response.value.flatMap { "\($0)" } ?? "",
            submitButtonDisabled: !response.submitButtonEnabled,
            deleteButtonDisplay: response.deleteButtonEnabled ? .visible("Delete") : .hidden
        ))
    }
    
    func presentProceedTextInput(response: HealthInputForm.ProceedTextInput.Response) {
        sceneViewModel.updateProceedTextInput(viewModel: .init(submitButtonDisabled: response.submitButtonDisabled))
    }
}
