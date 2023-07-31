//
//  CounterViewController.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 30/6/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
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
    
    let textController = TextInputController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dashboard"
        
        setupVIP()
        
        loadSwiftUIView(
            DashboardScreenSwiftUIView(
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

struct DashboardScreenSwiftUIView: View {
    weak var viewController: DashboardViewController?
    @ObservedObject var viewModel: DashboardSceneViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.categoryItems, id: \.category) { model in
                CategoryRow(
                    viewModel: model
                ).onPress {
                    viewController?.interactor?.tapCategory(
                        request: .init(categoryType: model.category)
                    )
                }
            }
        }
    }
}

fileprivate let categoryViewModel: [CategoryRowViewModel] = [
    .init(
        title: "Weight",
        value: "84 kg",
        lastUpdated: .init(value: Date().toString()),
        category: .weight
    ),
    .init(
        title: "Body Mass Index",
        value: "21",
        lastUpdated: .init(value: Date().toString()),
        category: .bodyMassIndex
    ),
    .init(
        title: "Height",
        value: "No Data",
        lastUpdated: .hidden,
        category: .height
    ),
]

struct DashboardScreenSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreenSwiftUIView(
            viewController: nil,
            viewModel: .init(categoryItems: categoryViewModel)
        )
    }
}
