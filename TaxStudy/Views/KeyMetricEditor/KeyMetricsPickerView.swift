//
//  KeyMetricsPickerView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/22/24.
//

import SwiftUI

struct KeyMetricsPickerView: View {
    @Binding var selectedKeyMetrics: [KeyMetricTypes]
    @Binding var visible: Bool
    @State private var searchText: String = ""
    var body: some View {
        VStack {
            // Add a search bar
            SearchBar(text: $searchText)
            List(KeyMetricCategories.allCases, id: \.self) { category in
                let filteredTypes = filteredTypes(for: category)
                if filteredTypes.isEmpty == false {
                    Section(category.label) {
                        ForEach(filteredTypes, id: \.self) { keyMetric in
                            KeyMetricToggle(keyMetric: keyMetric,
                                            isOn: selectedKeyMetrics.contains(keyMetric),
                                            selectedKeyMetrics: $selectedKeyMetrics)
                        }
                    }
                }
            }
            HStack {
                Spacer()
                Button("Done") {
                    visible.toggle()
                }
                .padding(.bottom, 5)
            }
            .padding(5)
            
        }
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
    KeyMetricsPickerView(selectedKeyMetrics: .constant([]), visible: .constant(true))
}
