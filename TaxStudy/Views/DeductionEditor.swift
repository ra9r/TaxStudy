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

struct DeductionEditor: View {
    @Environment(TaxScenarioManager.self) var manager
    @State private var selectedAdjustment: TaxAdjustmentType = .iraOr401kContribution
    @State private var showDescription: Bool = false
    @State private var amount: Double = 0
    
    var body: some View {
        VStack {
            HStack {
                Picker("Select a Tax Adjustment", selection: $selectedAdjustment) {
                    ForEach(TaxAdjustmentType.allCases, id: \.self) { adjustment in
                        Text(adjustment.label) // Display the localized label for each case
                            .tag(adjustment)
                    }
                }
                .pickerStyle(.automatic) // You can change the style as needed
                TextField("Enter amount", value: $amount, format: .currency(code: "USD"))
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
                Button {
                    manager.selectedTaxScenario.adjustments.items.append(.init(selectedAdjustment, amount: amount))
                } label: {
                    Image(systemName: "plus")
                    Text("Add")
                }
            }
            
            List(manager.selectedTaxScenario.adjustments.items, id: \.type) { deduction in
                VStack(alignment: .leading) {
                    Text(deduction.type.label)
                        .font(.headline)
                    Text("Amount: \(deduction.amount, specifier: "%.2f")")
                    if let description = deduction.description {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Deductions")
        }
        .padding(20)
    }
    
}

#Preview {
    @Previewable @State var manager = TaxScenarioManager()
    DeductionEditor()
        .environment(manager)
        .onAppear() {
            do {
                try manager.open(from: URL(fileURLWithPath: "/Users/rodney/Desktop/2024EstimatedTax.json"))
            } catch {
                print(error)
            }
        }
}
