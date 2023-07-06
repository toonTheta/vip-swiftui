//
//  Date+Extension.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 2/7/2566 BE.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
