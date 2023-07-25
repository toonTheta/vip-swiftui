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
    
//    func when<U: View>(
//        @ViewBuilder visible: (T) -> U,
//        @ViewBuilder hidden: () -> U
//    ) -> some View {
//        if let value = value {
//            return visible(value)
//        } else {
//            return hidden()
//        }
//    }
    
    @ViewBuilder
        func when(@ViewBuilder visible: (T) -> some View, @ViewBuilder hidden: () -> some View) -> some View {
            switch self {
            case .hidden:
                return AnyView(hidden())
            case let .visible(model):
                return AnyView(visible(model))
            }
//            if let value = value {
//
//            } else {
//
//            }
        }
}
