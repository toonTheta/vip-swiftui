//
//  CustomTextField.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 7/7/2566 BE.
//

import Combine
import SwiftUI

struct CustomTextField: View {
    private var controller: CustomTextFieldController
    private let placeholder: String?
    
    init(
        placeholder: String? = nil,
        controller: CustomTextFieldController? = nil
    ) {
        self.placeholder = placeholder
        self.controller = controller ?? CustomTextFieldController()
    }
    
    var body: some View {
        
        TextField(placeholder ?? "", text: Binding(
            get: { controller.text },
            set: { newValue in
                controller.userInputText = newValue
                controller.updateText(newValue)
            }
        ))
    }
}

class CustomTextFieldController: ObservableObject {
    @Published private(set) var text: String = ""
    @Published fileprivate var userInputText: String = ""
    
    func updateText(_ string: String) {
        text = string
    }
}

extension CustomTextField {
    func onTextChange(_ action: @escaping (String) -> Void) -> some View {
        return self.modifier(CustomTextFieldChangeModifier(controller: controller, action: action))
    }
}

struct CustomTextFieldChangeModifier: ViewModifier {
    var controller: CustomTextFieldController
    let action: (String) -> Void
    
    func body(content: Content) -> some View {
        content
            .onReceive(
                controller.$userInputText
                .dropFirst()
                .removeDuplicates()
            ) { text in
                action(text)
            }
    }
}
