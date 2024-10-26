//
//  TaxBracketEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/16/24.
//

import SwiftUI

struct TaxBracketEditor: View {
    @Binding var taxBrackets: TaxBrackets
    
    
    var body: some View {
        VStack {
            Table(taxBrackets.brackets) {
                TableColumn("Rate") { bracket in
                    RateField(bracket: bracket, taxBrackets: $taxBrackets)
                }
                .width(50)
                TableColumn("Single") { bracket in
                    ThresholdField(filingStatus: .single, bracket: bracket, taxBrackets: $taxBrackets)
                }
                TableColumn("MFJ") { bracket in
                    ThresholdField(filingStatus: .marriedFilingJointly, bracket: bracket, taxBrackets: $taxBrackets)
                }
                TableColumn("MFS") { bracket in
                    ThresholdField(filingStatus: .marriedFilingSeparately, bracket: bracket, taxBrackets: $taxBrackets)
                }
                TableColumn("HoH") { bracket in
                    ThresholdField(filingStatus: .headOfHousehold, bracket: bracket, taxBrackets: $taxBrackets)
                }
                TableColumn("QW") { bracket in
                    ThresholdField(filingStatus: .qualifiedWidow, bracket: bracket, taxBrackets: $taxBrackets)
                }
            }
            
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
            .padding()
            
            Spacer()
        }
        .padding()
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
