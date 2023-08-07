//
//  HealthDetailMainView.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 31/7/2566 BE.
//

import SwiftUI

protocol HealthDetailMainViewProtocol: AnyObject {
    func recordDidTap(recordId: UUID)
}

struct HealthDetailMainView: View {
    var viewProtocol: HealthDetailMainViewProtocol?
    @ObservedObject var viewModel: HealthDetailSceneViewModel
    
    var body: some View {
        viewModel.state.when(
            empty: {
                Text("No Data")
            },
            showRecords: { records in
                List {
                    Section {
                        LineChartView(data: records)
                    }
                    Section(header: Text(viewModel.unit)) {
                        ForEach(records, id: \.id) { item in
                            HStack {
                                Text("\(item.stringValue)")
                                Spacer()
                                Text(item.createdDate.toString())
                                    .foregroundColor(.secondary)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                                
                            }
                            .onPress { [weak viewProtocol] in
                                viewProtocol?.recordDidTap(recordId: item.id)
                            }
                        }
                    }
                }
            }
        )
    }
}

struct HealthDetailMainView_Previews: PreviewProvider {
    static var previews: some View {
        HealthDetailMainView(
            viewProtocol: nil,
            viewModel: .init(state: .showRecords(_records), unit: "KG")
        )
    }
}

// MARK: - Mock Preview Data
fileprivate let _records: [HealthRecordViewModel] = [
    HealthRecordViewModel(
        id: UUID(),
        value: 20,
        createdDate: Date.fromString("2023/01/01 10:30"),
        type: .weight
    ),
    HealthRecordViewModel(
        id: UUID(),
        value: 22,
        createdDate: Date.fromString("2023/02/01 10:30"),
        type: .weight
    ),
    HealthRecordViewModel(
        id: UUID(),
        value: 19,
        createdDate: Date.fromString("2023/03/01 10:30"),
        type: .weight
    ),
    HealthRecordViewModel(
        id: UUID(),
        value: 21,
        createdDate: Date.fromString("2023/04/01 10:30"),
        type: .weight
    )
]
