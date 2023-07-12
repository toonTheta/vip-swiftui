//
//  TextInput.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 7/7/2566 BE.
//

import Combine
import SwiftUI

struct TextInput: View {
    @ObservedObject private var controller: TextInputController
    private let placeholder: String?
    
    init(
        placeholder: String? = nil,
        controller: TextInputController? = nil
    ) {
        self.placeholder = placeholder
        self.controller = controller ?? TextInputController()
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

class TextInputController: ObservableObject {
    @Published private(set) var text: String = ""
    @Published fileprivate var userInputText: String = ""
    
    func updateText(_ string: String) {
        text = string
    }
}

extension TextInput {
    func onTextChange(_ action: @escaping (String) -> Void) -> some View {
        return self.modifier(TextInputChangeModifier(controller: controller, action: action))
    }
}

struct TextInputChangeModifier: ViewModifier {
    @ObservedObject var controller: TextInputController
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
