//
//  Display.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 12/7/2566 BE.
//

import Foundation
import SwiftUI

enum Display<T> {
    case hidden
    case visible(T)
    
    init(value: T?) {
        if let value = value {
            self = .visible(value)
        } else {
            self = .hidden
        }
    }
    
    @ViewBuilder
    func when(@ViewBuilder visible: (T) -> some View) -> some View {
        switch self {
        case .hidden:
            EmptyView()
        case let .visible(model):
            visible(model)
        }
    }
}
