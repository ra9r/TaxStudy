//
//  TaxBracketEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/16/24.
//

import SwiftUI

struct TaxBracketEditor: View {
    @Binding var taxBrackets: TaxBrackets
    var style: TaxBracketStyle = .rate
    
    // Initialize the initialTaxBrackets with the current taxBrackets
    init(taxBrackets: Binding<TaxBrackets>, style: TaxBracketStyle = .rate) {
        self._taxBrackets = taxBrackets
        self.style = style
    }

    var body: some View {
        let colums = [
            GridItem(.fixed(70)),
            GridItem(.fixed(90)),
            GridItem(.fixed(90)),
            GridItem(.fixed(90)),
            GridItem(.fixed(90)),
            GridItem(.fixed(90)),
            GridItem(.fixed(20))
        ]
        ScrollView {
            LazyVGrid(columns: colums, spacing: 10) {
                Heading(style.rawValue)
                Heading("Single")
                Heading("MFJ")
                Heading("MFS")
                Heading("HoH")
                Heading("QW")
                Spacer()
                
                ForEach(taxBrackets.brackets.indices, id: \.self) { index in
                    let bracket = taxBrackets.brackets[index]
                    
                    switch style {
                    case .number:
                        AmountField(bracket: bracket, taxBrackets: $taxBrackets)
                    case .rate:
                        RateField(bracket: bracket, taxBrackets: $taxBrackets)
                    }
                    ThresholdField(filingStatus: .single, bracket: bracket, taxBrackets: $taxBrackets)
                    ThresholdField(filingStatus: .marriedFilingJointly, bracket: bracket, taxBrackets: $taxBrackets)
                    ThresholdField(filingStatus: .marriedFilingSeparately, bracket: bracket, taxBrackets: $taxBrackets)
                    ThresholdField(filingStatus: .headOfHousehold, bracket: bracket, taxBrackets: $taxBrackets)
                    ThresholdField(filingStatus: .qualifiedWidow, bracket: bracket, taxBrackets: $taxBrackets)
                    Button {
                        delete(bracket)
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 12, weight: .bold))
                    }
                    .buttonStyle(.plain)
                }
                
                
            }
            .padding(5)
            .listStyle(.plain)
            .scrollContentBackground(.hidden) // Hides the default background color
            .background(Color.clear)
            Button {
                taxBrackets.brackets.append(TaxBracket(0.0, thresholds: [
                    .single: 0.0,
                    .marriedFilingJointly: 0.0,
                    .marriedFilingSeparately: 0.0,
                    .headOfHousehold: 0.0,
                    .qualifiedWidow: 0.0
                ]))
            } label: {
                HStack(alignment: .center) {
                    Image(systemName: "plus")
                    Text("Add Bracket")
                    Spacer()
                }
                .font(.system(size: 12, weight: .bold))
                .frame(maxWidth: .infinity) // Ensures it stretches across the columns
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 5)
        }
    }
    
    func delete(_ bracket: TaxBracket) {
        DispatchQueue.main.async {
            taxBrackets.brackets.removeAll(where: { $0.id == bracket.id })
        }
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
        .decorated(by: "percent")
        
    }
}

struct AmountField : View {
    var bracket: TaxBracket
    @Binding var taxBrackets: TaxBrackets
    var body: some View {
        TextField(
            "Amount",
            value: Binding(
                get: { bracket.rate },
                set: { newValue in
                    if let index = taxBrackets.brackets.firstIndex(where: { $0.id == bracket.id }) {
                        taxBrackets.brackets[index].rate = newValue
                    }
                }
            ),
            format: .number
        )
        .decorated(by: "dollarsign")
        
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
            format: .number
        )
        .decorated(by: "dollarsign")
    }
}

#Preview("Content", traits: .sizeThatFitsLayout) {
    @Previewable @State var taxBrackets = TaxFacts.official2024.ordinaryTaxBrackets
    TaxBracketEditor(taxBrackets: $taxBrackets)
        
}

enum TaxBracketStyle : String {
    case rate = "Rate"
    case number = "Amt"
}
