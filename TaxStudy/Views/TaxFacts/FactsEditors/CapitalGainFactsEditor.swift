//
//  OrdinaryFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/31/24.
//
import SwiftUI

struct CapitalGainFactsEditor : View {
    @Binding var taxScheme: TaxScheme
    
    var body: some View {
        ScrollView {
            DescribedContainer(
                "Capital Gains Tax Brackets",
                description: "Capital gains tax brackets determine the tax rate on profits earned from selling investments or assets held over a period of time. Long-term gains (held over a year) are typically taxed at lower rates than ordinary income, encouraging long-term investment.")
            {
                HStack {
                    Text("Capital Loss Limit").font(.headline)
                    TextField("Value", value: $taxScheme.capitalLossLimit, format: .number)
                        .decorated(by: "dollarsign")
                        .frame(maxWidth: 110)
                }
                
                Divider()
                
                TaxBracketEditor(taxBrackets: $taxScheme.capitalGainTaxBrackets)
                    
            }
        }
        .padding()
    }
}


#Preview {
    @Previewable @State var facts: TaxScheme = TaxScheme.official2024
    CapitalGainFactsEditor(taxScheme: $facts)
}
