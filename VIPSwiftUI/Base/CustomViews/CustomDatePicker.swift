//
//  CustomDatePicker.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 11/7/2566 BE.
//

import Combine
import SwiftUI

struct CustomDatePicker<Content: View>: View {
    private var controller: CustomDatePickerController
    private let displayedComponents: DatePickerComponents
    private let content: Content
    
    init(
        controller: CustomDatePickerController? = nil,
        displayedComponents: DatePickerComponents = .date,
        @ViewBuilder label: () -> Content
    ) {
        self.controller = controller ?? CustomDatePickerController()
        self.displayedComponents = displayedComponents
        self.content = label()
    }
    
    var body: some View {
        DatePicker(
            selection: Binding(
                get: { controller.date },
                set: { newValue in
                    controller.userInputDate = newValue
                    controller.updateDate(newValue)
                }),
            displayedComponents: displayedComponents,
            label: { content }
        )
    }
}

class CustomDatePickerController: ObservableObject {
    @Published private(set) var date: Date = Date()
    @Published fileprivate var userInputDate: Date = Date()
    
    func updateDate(_ date: Date) {
        self.date = date
    }
}

extension CustomDatePicker {
    func onChange(_ action: @escaping (Date) -> Void) -> some View {
        return self.modifier(CustomDatePickerChangeModifier(controller: controller, action: action))
    }
}

struct CustomDatePickerChangeModifier: ViewModifier {
    var controller: CustomDatePickerController
    let action: (Date) -> Void
    
    func body(content: Content) -> some View {
        content
            .onReceive(
                controller.$userInputDate
                .dropFirst()
                .removeDuplicates()
            ) { date in
                action(date)
            }
    }
}
