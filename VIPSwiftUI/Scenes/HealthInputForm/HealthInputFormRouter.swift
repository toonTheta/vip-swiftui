//
//  HealthInputFormRouter.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 7/7/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

protocol HealthInputFormRoutingLogic {}

protocol HealthInputFormDataPassing {
    var dataStore: HealthInputFormDataStore? { get }
}

final class HealthInputFormRouter: HealthInputFormRoutingLogic, HealthInputFormDataPassing {
    weak var viewController: HealthInputFormViewController?
    var dataStore: HealthInputFormDataStore?
}
