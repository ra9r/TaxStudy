//
//  DeductionEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/4/24.
//

//
//  ScenarioEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/28/24.
//

import SwiftUI

struct DeductionEditor<T : DeductionType & CaseIterable>: View where T.AllCases: RandomAccessCollection {
    @Binding var deductions: Deductions<T>
    @State private var selected: T? = nil
    @State private var showDescription: Bool = false
    @State private var amount: Double = 0
    
    var body: some View {
        VStack {
            HStack {
                Picker("Select", selection: $selected) {
                    Text("- Select -").tag(nil as T?)
                    ForEach(T.allCases, id: \.self) { deductionType in
                        Text(deductionType.label) // Display the localized label for each case
                            .tag(deductionType)
                    }
                }
                .pickerStyle(.automatic) // You can change the style as needed
                TextField("Enter amount", value: $amount, format: .currency(code: "USD"))
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
                Button {
                    if let selected {
                        deductions.add(.init(selected, amount: amount))
                    }
                } label: {
                    Image(systemName: "plus")
                    Text("Add")
                }
            }
            
            List(deductions.items, id: \.type) { deduction in
                VStack(alignment: .leading) {
                    Text(deduction.type.label)
                        .font(.headline)
                    Text("Amount: \(deduction.amount.asCurrency)")
                    if let description = deduction.description {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .contextMenu {
                    Button {
                        deductions.remove(deduction)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Deductions")
        }
        .padding(20)
    }
    
}

