//
//  DateInput.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 11/7/2566 BE.
//

import Combine
import SwiftUI

struct DateInput<Content: View>: View {
    @ObservedObject private var controller: DateInputController
    private let displayedComponents: DatePickerComponents
    private let content: Content
    
    init(
        controller: DateInputController? = nil,
        displayedComponents: DatePickerComponents = .date,
        @ViewBuilder label: () -> Content
    ) {
        self.controller = controller ?? DateInputController()
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

class DateInputController: ObservableObject {
    @Published private(set) var date: Date = .now
    @Published fileprivate var userInputDate: Date = .now
    
    func updateDate(_ date: Date) {
        self.date = date
    }
}

extension DateInput {
    func onChange(_ action: @escaping (Date) -> Void) -> some View {
        return self.modifier(DateInputChangeModifier(controller: controller, action: action))
    }
}

struct DateInputChangeModifier: ViewModifier {
    @ObservedObject var controller: DateInputController
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
