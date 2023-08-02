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
    
    private let viewModel = DashboardSceneViewModel(categoryItems: [])
    var interactor: DashboardInteractor!
    var presenter: DashboardPresenter!
    var router: DashboardRoutingLogic!
    
    let textController = CustomTextFieldController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dashboard"
        
        setupVIP()
        
        loadMainView(
            DashboardMainView(
                viewController: self,
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

private extension DashboardViewController {
    func setupVIP() {
        router = DashboardRouter(viewController: self)
        
        presenter = DashboardPresenter(
            viewController: self
        )
        
        interactor = DashboardInteractor(
            presenter: presenter,
            healthService: QueryService.shared
        )
    }
}
