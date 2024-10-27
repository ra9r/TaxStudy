//
//  TaxBracketEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/16/24.
//

import SwiftUI

struct TaxBracketEditor: View {
    @Binding var taxBrackets: TaxBrackets
    @State var multiSelection: Set<TaxBracket> = []
    
    // Initialize the initialTaxBrackets with the current taxBrackets
    init(taxBrackets: Binding<TaxBrackets>) {
        self._taxBrackets = taxBrackets
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Heading("Rate").frame(width: 60)
                Heading("Single").frame(width: 110)
                Heading("MFJ").frame(width: 110)
                Heading("MFS").frame(width: 110)
                Heading("HoH").frame(width: 110)
                Heading("QW").frame(width: 110)
            }
            List(selection: $multiSelection) {
                ForEach(taxBrackets.brackets, id: \.id) { bracket in
                    HStack {
                        RateField(bracket: bracket, taxBrackets: $taxBrackets).frame(width: 60)
                        ThresholdField(filingStatus: .single, bracket: bracket, taxBrackets: $taxBrackets).frame(width: 110)
                        ThresholdField(filingStatus: .marriedFilingJointly, bracket: bracket, taxBrackets: $taxBrackets).frame(width: 110)
                        ThresholdField(filingStatus: .marriedFilingSeparately, bracket: bracket, taxBrackets: $taxBrackets).frame(width: 110)
                        ThresholdField(filingStatus: .headOfHousehold, bracket: bracket, taxBrackets: $taxBrackets).frame(width: 110)
                        ThresholdField(filingStatus: .qualifiedWidow, bracket: bracket, taxBrackets: $taxBrackets).frame(width: 110)
                    }
                    .tag(bracket)
                    .contextMenu {
                        Button("Delete") {
                            delete()
                        }
                    }
                }
                .onMove(perform: move)
                Button {
                    taxBrackets.brackets.append(TaxBracket(0.0, thresholds: [
                        .single: 0.0,
                        .marriedFilingJointly: 0.0,
                        .marriedFilingSeparately: 0.0,
                        .headOfHousehold: 0.0,
                        .qualifiedWidow: 0.0
                    ]))
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add New Tax Bracket")
                    }
                }
                .buttonStyle(.plain)
            }
            Spacer()
        }
        .padding()
        
    }
    
    func delete() {
        DispatchQueue.main.async {
            // Remove the selected brackets
            for bracket in multiSelection {
                taxBrackets.brackets.removeAll(where: { $0.id == bracket.id })
            }
            
            // Clear the selection after deletion
            multiSelection.removeAll()
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        // Track the actual selected items before the move
        let selectedItems = multiSelection.map { $0.id }
        
        // Perform the move in the document
        taxBrackets.brackets.move(fromOffsets: source, toOffset: destination)
        
        // Update multiSelection by finding the new indices of the previously selected items
        multiSelection = Set(selectedItems.compactMap { id in
            taxBrackets.brackets.first(where: { $0.id == id })
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
