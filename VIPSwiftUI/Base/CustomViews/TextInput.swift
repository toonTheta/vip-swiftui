//
//  TextInput.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 7/7/2566 BE.
//

import Combine
import SwiftUI

struct TextInput: View {
    @ObservedObject var controller: TextInputController
    private var onTextChange: Callback<String>?
    
    init(
        controller: TextInputController? = nil,
        onTextChange: Callback<String>? = nil
    ) {
        self.controller = controller ?? TextInputController()
        self.onTextChange = onTextChange
    }
    
    var body: some View {
        TextField("placeholder", text: Binding(
            get: { controller.text },
            set: { newValue in
                controller.updateText(newValue)
             
                guard controller.stringCache != newValue else { return }
                controller.updateStringCache(newValue)
                onTextChange?(newValue)
            }
        ))
    }
}

class TextInputController: ObservableObject {
    @Published private(set) var text: String = ""
    fileprivate(set) var stringCache = ""
    
    func updateText(_ string: String) {
        text = string
    }
    
    fileprivate func updateStringCache(_ string: String) {
        stringCache = string
    }
}
