//
//  View+Extension.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 5/7/2566 BE.
//

import SwiftUI

private struct ExpandAreaTap: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.clear)
                .contentShape(Rectangle())
            content
        }
    }
}

extension View {
    func onPress(tap: @escaping () -> ()) -> some View {
        self.modifier(ExpandAreaTap()).onTapGesture(perform: tap)
    }
}
