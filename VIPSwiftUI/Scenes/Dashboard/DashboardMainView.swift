//
//  DashboardMainView.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 31/7/2566 BE.
//

import SwiftUI

struct DashboardMainView: View {
    weak var viewController: DashboardViewController?
    @ObservedObject var viewModel: DashboardSceneViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.categoryItems, id: \.category) { model in
                CategoryRow(
                    viewModel: model
                ).onPress {
                    viewController?.interactor?.tapCategory(
                        request: .init(categoryType: model.category)
                    )
                }
            }
        }
    }
}

// MARK: - Mock Preview Data

fileprivate let categoryViewModel: [CategoryRowViewModel] = [
    .init(
        title: "Weight",
        value: "84 kg",
        lastUpdated: .init(value: Date().toString()),
        category: .weight
    ),
    .init(
        title: "Body Mass Index",
        value: "21",
        lastUpdated: .init(value: Date().toString()),
        category: .bodyMassIndex
    ),
    .init(
        title: "Height",
        value: "No Data",
        lastUpdated: .hidden,
        category: .height
    ),
]

struct DashboardScreenSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardMainView(
            viewController: nil,
            viewModel: .init(categoryItems: categoryViewModel)
        )
    }
}
