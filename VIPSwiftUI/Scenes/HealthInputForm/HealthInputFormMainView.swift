//
//  HealthInputFormMainView.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 31/7/2566 BE.
//

import SwiftUI

protocol HealthInputFormMainViewProtocol: AnyObject {
    var dateInputController: CustomDatePickerController { get }
    var timeInputController: CustomDatePickerController { get }
    var textInputController: CustomTextFieldController { get }
    
    func dateInputDidChange(date: Date)
    func timeInputDidChange(date: Date)
    func valueInputDidChange(valueString: String)
    func saveButtonDidTap()
    func deleteButtonDidTap()
}

struct HealthInputFormMainView: View {
    var viewProtocol: HealthInputFormMainViewProtocol?
    @ObservedObject var viewModel: HealthInputFormSceneViewModel
    @State private var birthDate = Date()
    
    var body: some View {
        Form {
            CustomDatePicker(
                controller: viewProtocol?.dateInputController,
                label: {
                    Text(viewModel.dateTitle)
                }
            ).onChange { [weak viewProtocol] date in
                viewProtocol?.dateInputDidChange(date: date)
            }
            
            
            CustomDatePicker(
                controller: viewProtocol?.timeInputController,
                displayedComponents: [.hourAndMinute]
            ) {
                Text(viewModel.timeTitle)
            }.onChange { [weak viewProtocol] date in
                viewProtocol?.timeInputDidChange(date: date)
            }
            
            HStack {
                Text(viewModel.unitTitle)
                Spacer()
                CustomTextField(
                    placeholder: "value",
                    controller: viewProtocol?.textInputController
                )
                .onTextChange { [weak viewProtocol] text in
                    viewProtocol?.valueInputDidChange(valueString: text)
                }
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: 80)
                .keyboardType(.decimalPad)
            }
            
            Section {
                Button("Save") { [weak viewProtocol] in
                    viewProtocol?.saveButtonDidTap()
                }
                .disabled(viewModel.saveButtonDisabled)
                .frame(maxWidth: .infinity) // center the button
            }
            
            viewModel.deleteButtonDisplay.when(visible: { title in
                Section {
                    Button(title) { [weak viewProtocol] in
                        viewProtocol?.deleteButtonDidTap()
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
