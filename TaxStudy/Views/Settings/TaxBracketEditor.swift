//
//  TaxBracketEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/16/24.
//

import SwiftUI

struct TaxBracketEditor: View {
    @Binding var taxBrackets: TaxBrackets
    @State var multiSelection: Set<Int> = []
    private var initialTaxBrackets: TaxBrackets
    
    // Initialize the initialTaxBrackets with the current taxBrackets
    init(taxBrackets: Binding<TaxBrackets>) {
        self._taxBrackets = taxBrackets
        self.initialTaxBrackets = taxBrackets.wrappedValue.deepCopy
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Heading("Rate")
                Heading("Single")
                Heading("MFJ")
                Heading("MFS")
                Heading("HoH")
                Heading("QW")
            }
            List(selection: $multiSelection) {
                ForEach(taxBrackets.brackets.indices, id: \.self) { index in
                    let bracket = taxBrackets.brackets[index]
                    HStack {
                        RateField(bracket: bracket, taxBrackets: $taxBrackets)
                        ThresholdField(filingStatus: .single, bracket: bracket, taxBrackets: $taxBrackets)
                        ThresholdField(filingStatus: .marriedFilingJointly, bracket: bracket, taxBrackets: $taxBrackets)
                        ThresholdField(filingStatus: .marriedFilingSeparately, bracket: bracket, taxBrackets: $taxBrackets)
                        ThresholdField(filingStatus: .headOfHousehold, bracket: bracket, taxBrackets: $taxBrackets)
                        ThresholdField(filingStatus: .qualifiedWidow, bracket: bracket, taxBrackets: $taxBrackets)
                    }
                    .contextMenu {
                        Button("Delete") {
                            print("Delete Clicked")
                        }
                    }
                }
                .onMove(perform: move)
            }
            HStack {
                // Add New Tax Bracket Button
                Button(action: {
                    taxBrackets.brackets.append(TaxBracket(0.0, thresholds: [
                        .single: 0.0,
                        .marriedFilingJointly: 0.0,
                        .marriedFilingSeparately: 0.0,
                        .headOfHousehold: 0.0,
                        .qualifiedWidow: 0.0
                    ]))
                }) {
                    Text("Add New Tax Bracket")
                }
                Button(action: reset) {
                    Text("Reset to Initial State")
                }
                .padding()
                
            }
            Spacer()
        }
        .padding()
    }
    
    // The reset function to restore the original state
    func reset() {
        taxBrackets = initialTaxBrackets
    }
    
    func move(from source: IndexSet, to destination: Int) {
        // Track the actual selected items before the move
        let selectedItems = multiSelection.map { taxBrackets.brackets[$0].rate }
        
        // Perform the move in the document
        taxBrackets.brackets.move(fromOffsets: source, toOffset: destination)
        
        // Update multiSelection by finding the new indices of the previously selected items
        multiSelection = Set(selectedItems.compactMap { rate in
            taxBrackets.brackets.firstIndex(where: { $0.rate == rate })
        })
    }
}

struct Heading : View {
    var label: String
    
    init(_ label: String) {
        self.label = label
    }
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
        }
        .font(.headline)
        .padding(.leading)
        .frame(maxWidth: .infinity)
    }
}

struct RateField : View {
    var bracket: TaxBracket
    @Binding var taxBrackets: TaxBrackets
    var body: some View {
        TextField(
            "Rate",
            value: Binding(
                get: { bracket.rate },
                set: { newValue in
                    if let index = taxBrackets.brackets.firstIndex(where: { $0.id == bracket.id }) {
                        taxBrackets.brackets[index].rate = newValue
                    }
                }
            ),
            format: .percent
        )
        .textFieldStyle(.plain)
        
    }
}

struct ThresholdField : View {
    var filingStatus: FilingStatus
    var bracket: TaxBracket
    @Binding var taxBrackets: TaxBrackets
    var body: some View {
        TextField(
            "",
            value: Binding(
                get: { bracket.thresholds[filingStatus]! },
                set: { newValue in
                    if let index = taxBrackets.brackets.firstIndex(where: { $0.id == bracket.id }) {
                        taxBrackets.brackets[index].thresholds[filingStatus]! = newValue
                    }
                }
            ),
            format: .currency(code: "USD")
        )
        .textFieldStyle(.plain)
    }
}

#Preview {
    @Previewable @State var taxBrackets = OrdinaryTaxBrackets2024
    TaxBracketEditor(taxBrackets: $taxBrackets)
}
