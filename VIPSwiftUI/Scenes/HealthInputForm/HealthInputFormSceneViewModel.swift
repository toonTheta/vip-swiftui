//
//  HealthInputFormSceneViewModel.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 7/7/2566 BE.
//

import SwiftUI

class HealthInputFormSceneViewModel: ObservableObject {
    typealias HourMinutePair = (hour: Int, minute: Int)
    
    @Published var date: String
    @Published var time: HourMinutePair
    @Published var unitLabel: String
    @Published var value: Double
    
    init(date: String, time: HourMinutePair, value: Double, unitLabel: String) {
        self.date = date
        self.time = time
        self.value = value
        self.unitLabel = unitLabel
    }
}
