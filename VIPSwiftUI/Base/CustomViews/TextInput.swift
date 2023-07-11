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
    
    init(
        controller: TextInputController? = nil,
        onTextChange: ((String) -> Void)? = nil
    ) {
        self.controller = controller ?? TextInputController()
        
        self.controller.$userInputText
            .dropFirst()
            .removeDuplicates()
            .sink { onTextChange?($0) }
            .store(in: &self.controller.cancellables)
    }
    
    var body: some View {
        TextField("placeholder", text: Binding(
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
    fileprivate var cancellables = Set<AnyCancellable>()
    
    func updateText(_ string: String) {
        text = string
    }
}
