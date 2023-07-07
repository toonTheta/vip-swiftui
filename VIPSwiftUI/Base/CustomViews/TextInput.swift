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
        TextField("placeholder", text: $controller.text)
            .onReceive(Just(controller.text)) { text in
                onTextChange?(text)
            }
    }
}

struct TextInput_Previews: PreviewProvider {
    static var previews: some View {
        TextInput()
            .previewLayout(.sizeThatFits)
    }
}

class TextInputController: ObservableObject {
    @Published var text: String = ""
    
    func text(_ string: String) {
        text = string
    }
}
