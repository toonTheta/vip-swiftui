//
//  HealthInputFormMainView.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 31/7/2566 BE.
//

import SwiftUI

struct HealthInputFormMainView: View {
    weak var viewController: HealthInputFormViewController?
    @ObservedObject var viewModel: HealthInputFormSceneViewModel
    @State private var birthDate = Date()
    
    var body: some View {
        Form {
            DateInput(
                controller: viewController?.dateInputController,
                label: {
                    Text(viewModel.dateTitle)
                }
            ).onChange { [weak viewController] date in
                viewController?
                    .interactor?
                    .proceedDateInput(request: .init(date: date))
            }
            
            
            DateInput(
                controller: viewController?.timeInputController,
                displayedComponents: [.hourAndMinute]
            ) {
                Text(viewModel.timeTitle)
            }.onChange { [weak viewController] date in
                viewController?
                    .interactor?
                    .proceedDateInput(request: .init(date: date))
            }
            
            HStack {
                Text(viewModel.unitTitle)
                Spacer()
                TextInput(
                    placeholder: "value",
                    controller:viewController?.textInputController
                )
                .onTextChange { [weak viewController] text in
                    viewController?
                        .interactor?
                        .proceedTextInput(
                            request: .init(text: text)
                        )
                }
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: 80)
                .keyboardType(.decimalPad)
            }
            
            Section {
                Button("Save") { [weak viewController] in
                    viewController?.handleTapAddData()
                }
                .disabled(viewModel.saveButtonDisabled)
                .frame(maxWidth: .infinity) // center the button
            }
            
            viewModel.deleteButtonDisplay.when(visible: { title in
                Section {
                    Button(title) { [weak viewController] in
                        viewController?.handleTapDeleteData()
                    }
                    .frame(maxWidth: .infinity) // center the button
                }.foregroundColor(.red)
            })
            
        }
    }
}


struct HealthInputFormView_Previews: PreviewProvider {
    static var previews: some View {
        HealthInputFormMainView(viewModel: sceneViewModel)
    }
}

// MARK: - Mock Preview Data

fileprivate let sceneViewModel = HealthInputFormSceneViewModel(
    dateTitle: "Date Ja",
    timeTitle: "Time Ja",
    unitTitle: "KG",
    saveButtonDisabled: true,
    deleteButtonTitleDisplay: .visible("Delete Ja")
)
