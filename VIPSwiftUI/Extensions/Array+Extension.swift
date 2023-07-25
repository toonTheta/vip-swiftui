//
//  Array+Extension.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 12/7/2566 BE.
//

import Foundation

extension Array {
    func elements(at indexes: IndexSet) -> [Element?] {
        return indexes.map { index in
            guard index >= 0 && index < count else { return nil }
            return self[index]
        }
    }
}
