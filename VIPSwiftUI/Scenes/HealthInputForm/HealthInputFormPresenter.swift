//
//  HealthInputFormPresenter.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 7/7/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
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
    weak var viewController: HealthInputFormDisplayLogic?
    var worker: HealthInputFormPresenterWorkerProtocol

    var controller: HealthInputFormDisplayLogic? {
        return viewController
    }

    init(
        viewController: HealthInputFormDisplayLogic,
        worker: HealthInputFormPresenterWorkerProtocol = HealthInputFormPresenterWorker()
    ) {
        self.viewController = viewController
        self.worker = worker
    }
    
    func presentPreparedData(response: HealthInputForm.PrepareData.Response) {
        viewController?.displayPreparedData(viewModel: .init(
            dateTitle: "Date",
            timeTitle: "Time",
            unitTitle: worker.mapUnitLabel(recordType: response.recordType),
            dateValue: response.date,
            textValue: response.value.flatMap { "\($0)" } ?? "",
            submitButtonDisabled: !response.submitButtonEnabled,
            deleteButtonDisplay: response.deleteButtonEnabled ? .visible("Delete") : .hidden
        ))
    }
    
    func presentProceedTextInput(response: HealthInputForm.ProceedTextInput.Response) {
        viewController?.displayProceedTextInput(viewModel: .init(submitButtonDisabled: response.submitButtonDisabled))
    }
}
