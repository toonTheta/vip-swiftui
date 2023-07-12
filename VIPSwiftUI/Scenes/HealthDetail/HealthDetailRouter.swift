//
//  HealthDetailRouter.swift
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

protocol HealthDetailRoutingLogic {
    func routeToAddHealthRecord()
}

protocol HealthDetailDataPassing {
    var dataStore: HealthDetailDataStore? { get }
}

final class HealthDetailRouter: HealthDetailRoutingLogic, HealthDetailDataPassing {
    weak var viewController: HealthDetailViewController?
    var dataStore: HealthDetailDataStore?
    
    
    func routeToAddHealthRecord() {
        guard let dataStore else { return }
        
        let inputFormVC = HealthInputFormViewController(
            delegate: viewController,
            sceneOption: .add(recordType: dataStore.recordType)
        )
        
        let navVC = UINavigationController(rootViewController: inputFormVC)
        
        viewController?.present(navVC, animated: true)
    }
}
