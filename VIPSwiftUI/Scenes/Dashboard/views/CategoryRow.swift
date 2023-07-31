//
//  CategoryRow.swift
//  CleanSwiftUI
//
//  Created by Siradanai.s on 2/7/2566 BE.
//

import SwiftUI

struct CategoryRowViewModel {
    let title: String
    let value: String
    let lastUpdated: String
    let category: HealthRecordType
}

struct CategoryRow: View {
    let viewModel: CategoryRowViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                Text(viewModel.title)
                    .font(.headline)
                    .foregroundColor(.blue)
                Spacer()
                Text("\(viewModel.lastUpdated)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }
            
            Text(viewModel.value)
                .font(.headline)
        }
        .padding(.all)
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static private let weightViewModel = CategoryRowViewModel(
        title: "Weight",
        value: "84",
        lastUpdated: Date().toString(),
        category: .weight
    )
    
    static var previews: some View {
        CategoryRow(
           viewModel: weightViewModel
        ).previewLayout(.sizeThatFits)
    }
}
