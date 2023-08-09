//
//  HealthInputFormMainView.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 31/7/2566 BE.
//

import SwiftUI

protocol HealthInputFormMainViewDelegate: AnyObject {
    func dateInputDidChange(date: Date)
    func timeInputDidChange(date: Date)
    func valueInputDidChange(valueString: String)
    func saveButtonDidTap()
    func deleteButtonDidTap()
}

struct HealthInputFormMainView: View {
    var delegate: HealthInputFormMainViewDelegate?
    @ObservedObject var viewModel: HealthInputFormSceneViewModel
    @State private var birthDate = Date()
    
    var body: some View {
        Form {
            DatePicker(
                selection: $viewModel.dateTimeValue,
                displayedComponents: [.date],
                label: { Text(viewModel.dateTitle) }
            ).onChange(of: viewModel.dateTimeValue) { [weak delegate] dateTimeValue in
                delegate?.dateInputDidChange(date: dateTimeValue)
            }
            
            DatePicker(
                selection: $viewModel.dateTimeValue,
                displayedComponents: [.hourAndMinute],
                label: { Text(viewModel.dateTitle) }
            ).onChange(of: viewModel.dateTimeValue) { [weak delegate] dateTimeValue in
                delegate?.dateInputDidChange(date: dateTimeValue)
            }
            
            HStack {
                Text(viewModel.unitTitle)
                Spacer()
                TextField("value", text: $viewModel.textInputValue)
                    .onChange(of: viewModel.textInputValue) { [weak delegate] textValue in
                        delegate?.valueInputDidChange(
                            valueString: textValue
                        )
                    }
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: 80)
                .keyboardType(.decimalPad)
            }
            
            Section {
                Button("Save") { [weak delegate] in
                    delegate?.saveButtonDidTap()
                }
                .disabled(viewModel.saveButtonDisabled)
                .frame(maxWidth: .infinity) // center the button
            }
            
            viewModel.deleteButtonDisplay.when(visible: { title in
                Section {
                    Button(title) { [weak delegate] in
                        delegate?.deleteButtonDidTap()
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
    dateTimeValue: Date(),
    textValue: "23",
    saveButtonDisabled: true,
    deleteButtonTitleDisplay: .visible("Delete Ja")
)
