//
//  HealthDetailViewController.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 2/7/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SwiftUI

protocol HealthDetailDisplayLogic: AnyObject {
    func displayDetail(viewModel: HealthDetail.FetchDetail.ViewModel)
}

final class HealthDetailViewController: BaseUIViewController, HealthDetailDisplayLogic {
    var interactor: HealthDetailBusinessLogic?
    var router: (HealthDetailRoutingLogic & HealthDetailDataPassing)?
    
    private let sceneViewModel = HealthDetailSceneViewModel(
        records: [],
        unit: ""
    )
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(recordType: HealthRecordType) {
        super.init(nibName: nil, bundle: nil)
        
        setupVIP(recordType: recordType)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.fetchDetail(request: .init())
        
        navigationItem.title = "Detail"
        loadSwiftUIView(
            HealthDetailScreenSwiftUIView(
                interactor: interactor,
                viewModel: sceneViewModel
            )
        )
    }
    
    func displayDetail(viewModel: HealthDetail.FetchDetail.ViewModel) {
        sceneViewModel.records = viewModel.records
         sceneViewModel.unit = viewModel.unit
    }
}

private extension HealthDetailViewController {
    func setupVIP(recordType: HealthRecordType) {
        let viewController = self
        
        let presenter = HealthDetailPresenter(
            viewController: viewController
        )
        
        let interactor = HealthDetailInteractor(
            presenter: presenter,
            recordType: recordType,
            healthService: QueryService.shared
        )
        
        let router = HealthDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
}

struct HealthDetailScreenSwiftUIView: View {
    var interactor: HealthDetailBusinessLogic?
    @ObservedObject var viewModel: HealthDetailSceneViewModel
    
    var body: some View {
        List {
            
            Section {
                Text("Graph")
            }
            
            Section(header: Text(viewModel.unit)) {
                ForEach(viewModel.records, id: \.id) { item in
                    Text("\(item.value)")
                }
            }
        }
    }
}

struct HealthDetailScreenSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HealthDetailScreenSwiftUIView(
            interactor: nil,
            viewModel: .init(
                records: _records,
                unit: "KG"
            )
        )
    }
}

fileprivate let _records: [HealthRecordViewModel] = [
    .init(
        id: .init(),
        value: 12,
        createdDate: Date(),
        type: .weight
    ),
    .init(
        id: .init(),
        value: 12,
        createdDate: Date(),
        type: .weight
    ),
    .init(
        id: .init(),
        value: 12,
        createdDate: Date(),
        type: .weight
    )
]
