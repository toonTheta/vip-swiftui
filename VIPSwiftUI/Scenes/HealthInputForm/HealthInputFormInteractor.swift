//
//  HealthInputFormInteractor.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 7/7/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

protocol HealthInputFormBusinessLogic {
    func proceedTextInput(request: HealthInputForm.ProceedTextInput.Request)
}

protocol HealthInputFormDataStore {}

final class HealthInputFormInteractor: HealthInputFormBusinessLogic, HealthInputFormDataStore {
    var presenter: HealthInputFormPresentationLogic
    private var worker: HealthInputFormWorkerProtocol

    init(
        worker: HealthInputFormWorkerProtocol = HealthInputFormWorker(),
        presenter: HealthInputFormPresentationLogic
    ) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func proceedTextInput(request: HealthInputForm.ProceedTextInput.Request) {
        let buttonEnabled = request.text.isEmpty == false
        presenter.presentProceedTextInput(response: .init(addButtonEnabled: buttonEnabled))
    }
}
