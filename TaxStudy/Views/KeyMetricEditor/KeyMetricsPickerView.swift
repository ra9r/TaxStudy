//
//  KeyMetricsPickerView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/22/24.
//

import SwiftUI

struct KeyMetricsPickerView: View {
    @State private var searchText: String = ""
    @State private var selectedKeyMetric: KeyMetricTypes? = nil
    
    var onComplete: (KeyMetricTypes) -> Void

    var body: some View {
        VStack {
            // Add a search bar
            SearchBar(text: $searchText)
            List(KeyMetricCategories.allCases, id: \.self, selection: $selectedKeyMetric) { category in
                let filteredTypes = filteredTypes(for: category)
                if filteredTypes.isEmpty == false {
                    Section(category.label) {
                        ForEach(filteredTypes, id: \.self) { keyMetric in
                            let isSelected = selectedKeyMetric == keyMetric
                            Text(keyMetric.label)
                            
                        }
                    }
                }
            }
            HStack {
                Spacer()
                Button("Add Metric") {
                    if let selectedKeyMetric = selectedKeyMetric {
                        onComplete(selectedKeyMetric)
                    }
                }
                .disabled(selectedKeyMetric == nil)
            }
            .padding(5)
        }
        .padding(5)
    }
    
    // Function to filter the types in each category
    func filteredTypes(for category: KeyMetricCategories) -> [KeyMetricTypes] {
        if searchText.isEmpty {
            return category.types // No filtering if search is empty
        } else {
            return category.types.filter { keyMetric in
                keyMetric.label.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    KeyMetricsPickerView() { keyMetrics in
        print(keyMetrics.label)
    }
}
