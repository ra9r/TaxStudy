//
//  KeyMetricsPickerView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/22/24.
//

import SwiftUI

struct KeyMetricsPickerView: View {
    @Binding var selectedKeyMetrics: Set<KeyMetricTypes>
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
                            KeyMetricToggle(keyMetric: keyMetric, isOn: selectedKeyMetrics.contains(keyMetric), selectedKeyMetrics: $selectedKeyMetrics)
                        }
                    }
                }
            }
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
// A basic search bar component using a TextField
struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search key metrics", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}

struct KeyMetricToggle: View {
    var keyMetric: KeyMetricTypes
    @State var isOn: Bool
    @Binding var selectedKeyMetrics: Set<KeyMetricTypes>
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(keyMetric.label)
        }
        .onChange(of: isOn) { oldValue, newValue in
            print("\(keyMetric) is now \(newValue)")
            if newValue {
                selectedKeyMetrics.insert(keyMetric)
            } else {
                selectedKeyMetrics.remove(keyMetric)
            }
        }
    }
}

#Preview {
    @Previewable @State var keyMetrics: Set<KeyMetricTypes> = [
        .grossIncome,
        .totalIncome,
        .agi,
        ]
    KeyMetricsPickerView(selectedKeyMetrics: $keyMetrics)
}
