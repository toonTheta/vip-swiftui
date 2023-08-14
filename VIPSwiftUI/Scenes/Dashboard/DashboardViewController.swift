//
//  CounterViewController.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 30/6/2566 BE.
//  Copyright (c) 2023. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SwiftUI

protocol DashboardDisplayLogic: AnyObject {
    func displayCategory(categoryItems: [CategoryRowViewModel])
    func displayTapCategory(viewModel: Dashboard.TapCategory.ViewModel)
}

class DashboardViewController: BaseUIViewController, DashboardDisplayLogic {
    private let viewModel = DashboardSceneViewModel()
    var interactor: DashboardInteractor!
    var router: DashboardRoutingLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dashboard"
        
        setupVIP()
        
        loadMainView(
            DashboardSceneMainView(
                delegate: self,
                viewModel: viewModel
            )
        )
    }

    func displayCategory(categoryItems: [CategoryRowViewModel]) {
        viewModel.categoryItems = categoryItems
    }
    
    func displayTapCategory(viewModel: Dashboard.TapCategory.ViewModel) {
        router.routeToHealthDetail(type: viewModel.categoryType)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        interactor.fetchCateogory(request: .init())
    }
}

extension DashboardViewController: DashboardSceneMainViewDelegate {
    func categoryDidTap(type: HealthRecordType) {
        interactor?.tapCategory(
            request: .init(categoryType: type)
        )
    }
}

private extension DashboardViewController {
    func setupVIP() {
        let viewController = self
        
        let presenter = DashboardPresenter(
            viewController: self
        )
        
        let interactor = DashboardInteractor(
            presenter: presenter,
            healthService: QueryService.shared
        )
        
        let router = DashboardRouter(viewController: self)
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }
}
