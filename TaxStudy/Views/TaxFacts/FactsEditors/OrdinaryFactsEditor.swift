//
//  OrdinaryFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/31/24.
//
import SwiftUI

struct OrdinaryFactsEditor : View {
    @Binding var taxScheme: TaxScheme
    
    var body: some View {
        ScrollView {
            DescribedContainer(
                "Ordinary Tax Brackets",
                description: "Ordinary income tax brackets are used to calculate the amount of tax owed based on income level. Each bracket applies a different tax rate to portions of your income, ensuring that those with higher earnings pay a higher tax rate on their additional income. This system helps create a fair tax structure by progressively increasing the tax rate as income rises.")
            {
                TaxBracketEditor(taxBrackets: $taxScheme.ordinaryTaxBrackets)
                    
            }
        }
        .padding()
    }
}


#Preview {
    @Previewable @State var facts: TaxScheme = TaxScheme.official2024
    OrdinaryFactsEditor(taxScheme: $facts)
}
