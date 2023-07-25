//
//  LineGraph.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 12/7/2566 BE.
//

import SwiftUI
import Charts

struct LineChartView: View {
    let data: [HealthRecordViewModel]
    
    var body: some View {
        VStack {
            Chart {
                ForEach(data, id: \.id) { item in
                    LineMark(
                        x: .value("Date", item.createdDate),
                        y: .value("Value", item.value)
                    )
                }
            }
            .frame(height: 300)
        }
    }
}

struct LineChartView_Preview: PreviewProvider {
    static var previews: some View {
        return LineChartView(data: sampleData)
            .previewLayout(.fixed(width: 400, height: 260))
    }
}

fileprivate let sampleData: [HealthRecordViewModel] = [
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
