//
//  HealthInputFormViewController.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 7/7/2566 BE.
//  Copyright (c) 2023. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SwiftUI

protocol HealthInputFormViewControllerDelegate: AnyObject {
    func didSubmitHealthInputData(withValue value: Double, date: Date, mode: HealthInputForm.SceneOption)
    func didPressDelete(record: HealthRecord)
}

protocol HealthInputFormDisplayActionLogic: AnyObject {
}

final class HealthInputFormViewController: BaseUIViewController, HealthInputFormDisplayActionLogic, HealthInputFormSceneMainViewDelegate {
    var interactor: HealthInputFormBusinessLogic?
    var router: (HealthInputFormRoutingLogic & HealthInputFormDataPassing)?
    
    private let sceneViewModel = HealthInputFormSceneViewModel()
    weak var delegate: HealthInputFormViewControllerDelegate?
    
    init(
        delegate: HealthInputFormViewControllerDelegate?,
        sceneOption: HealthInputForm.SceneOption
    ) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        setupVIP(sceneOption: sceneOption)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMainView(HealthInputFormSceneMainView(
            delegate: self,
            viewModel: sceneViewModel
        ))
        
        interactor?.prepareData(request: .init())
    }
    
    func displayProceedTextInput(viewModel: HealthInputForm.ProceedTextInput.ViewModel) {
        sceneViewModel.saveButtonDisabled = viewModel.submitButtonDisabled
    }
}

extension HealthInputFormViewController {
    func dateInputDidChange(date: Date) {
        interactor?.proceedDateInput(request: .init(date: date))
    }
    
    func timeInputDidChange(date: Date) {
        interactor?.proceedDateInput(request: .init(date: date))
    }
    
    func valueInputDidChange(valueString: String) {
        interactor?.proceedTextInput(request: .init(text: valueString))
    }
    
    func saveButtonDidTap() {
        guard
            let date = interactor?.inputDate,
            let text = interactor?.inputText,
            let doubleValue = Double(text),
            let sceneOption = interactor?.sceneOption
        else { return }
        
        delegate?.didSubmitHealthInputData(
            withValue: doubleValue,
            date: date,
            mode: sceneOption
        )
        
        dismiss(animated: true)
    }
    
    func deleteButtonDidTap() {
        guard
            let record = interactor?.record
        else { return }
        
        delegate?.didPressDelete(record: record)
        dismiss(animated: true)
    }
}

private extension HealthInputFormViewController {
    func setupVIP(sceneOption: HealthInputForm.SceneOption) {
        let viewController = self
        
        let presenter = HealthInputFormPresenter(
            viewController: viewController, 
            sceneViewModel: sceneViewModel
        )
        
        let interactor = HealthInputFormInteractor(
            presenter: presenter,
            sceneOption: sceneOption
        )
        
        let router = HealthInputFormRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
}
