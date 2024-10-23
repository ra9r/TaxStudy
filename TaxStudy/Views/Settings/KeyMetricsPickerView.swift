//
//  KeyMetricsPickerView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/22/24.
//

import SwiftUI

struct KeyMetricsPickerView: View {
    @State var selectedKeyMetrics: [KeyMetricTypes] = []
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
                            KeyMetricToggle(keyMetric: keyMetric, selectedKeyMetrics: $selectedKeyMetrics)
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
    @State var isOn: Bool = false
    @Binding var selectedKeyMetrics: [KeyMetricTypes]
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(keyMetric.label)
        }
        .onChange(of: isOn) { oldValue, newValue in
            print("\(keyMetric) is now \(newValue)")
            if newValue {
                selectedKeyMetrics.append(keyMetric)
            } else {
                selectedKeyMetrics.removeAll(where: { $0 == keyMetric })
            }
        }
    }
}

#Preview {
    KeyMetricsPickerView()
}
