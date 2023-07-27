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
        state: .empty,
        unit: ""
    )
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(recordType: HealthRecordType) {
        super.init(nibName: nil, bundle: nil)
        setupVIP(recordType: recordType)
        setupBarButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.fetchDetail(request: .init())
        
        navigationItem.title = "Detail"
        
        loadSwiftUIView(
            HealthDetailScreenSwiftUIView(
                viewController: self,
                viewModel: sceneViewModel
            )
        )
    }
    
    func displayDetail(viewModel: HealthDetail.FetchDetail.ViewModel) {
        sceneViewModel.unit = viewModel.unit
        
        if viewModel.updateWithAnimation {
            withAnimation {
                sceneViewModel.state = viewModel.state
            }
        } else {
            sceneViewModel.state = viewModel.state
        }
    }
    
    func handleTapRecord(_ id: UUID) {
        router?.routeToEditData(recordId: id)
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
    
    func setupBarButton() {
        let addButton = UIBarButtonItem(title: "Add Data", style: .plain, target: self, action: #selector(handleTapAddData))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func handleTapAddData() {
        router?.routeToAddHealthRecord()
    }
}

extension HealthDetailViewController: HealthInputFormViewControllerDelegate {
    func didSubmitHealthInputData(
        withValue value: Double,
        date: Date,
        mode: HealthInputForm.SceneOption
    ) { 
        interactor?.submitRecord(
            request: .init(value: value, date: date, mode: mode)
        )
    }
    
    func didPressDelete(record: HealthRecord) {
        interactor?.removeDetail(request: .init(record: record))
    }
}

struct HealthDetailScreenSwiftUIView: View {
    var viewController: HealthDetailViewController?
    @ObservedObject var viewModel: HealthDetailSceneViewModel
    
    var body: some View {
        viewModel.state.when(
            empty: {
                Text("No Data")
            },
            showRecords: { records in
                List {
                    Section {
                        LineChartView(data: records)
                    }
                    Section(header: Text(viewModel.unit)) {
                        ForEach(records, id: \.id) { item in
                            Text("\(item.stringValue)")
                                .onPress { [weak viewController] in
                                    viewController?.handleTapRecord(item.id)
                                }
                        }
                    }
                }
            }
        )
    }
}

struct HealthDetailScreenSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HealthDetailScreenSwiftUIView(
            viewController: nil,
            viewModel: .init(state: .empty, unit: "KG")
        )
    }
}

fileprivate let _records: [HealthRecordViewModel] = [
    HealthRecordViewModel(
        id: UUID(),
        value: 20,
        createdDate: Date.fromString("2023/01/01 10:30"),
        type: .weight
    ),
    HealthRecordViewModel(
        id: UUID(),
        value: 22,
        createdDate: Date.fromString("2023/02/01 10:30"),
        type: .weight
    ),
    HealthRecordViewModel(
        id: UUID(),
        value: 19,
        createdDate: Date.fromString("2023/03/01 10:30"),
        type: .weight
    ),
    HealthRecordViewModel(
        id: UUID(),
        value: 21,
        createdDate: Date.fromString("2023/04/01 10:30"),
        type: .weight
    )
]
