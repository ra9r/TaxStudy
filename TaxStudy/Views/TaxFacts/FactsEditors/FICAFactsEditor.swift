//
//  OrdinaryFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/31/24.
//
import SwiftUI

struct FICAFactsEditor : View {
    @Binding var taxScheme: TaxScheme
    
    var body: some View {
        ScrollView {
            DescribedContainer(
                "FICA Thresholds",
                description: "The Federal Insurance Contributions Act (FICA) tax comprises two components: Social Security and Medicare taxes")
            {
                Text("Social Security Thresholds")
                    .font(.title2)
                    .padding(.vertical)
                
                TaxBracketEditor(taxBrackets: $taxScheme.ssTaxThresholds)
                
                Text("Medicare Thresholds")
                    .font(.title2)
                    .padding(.vertical)
                
                TaxBracketEditor(taxBrackets: $taxScheme.medicareTaxThresholds)
                    
            }
        }
        .padding()
    }
}


#Preview {
    @Previewable @State var facts: TaxScheme = TaxScheme.official2024
    FICAFactsEditor(taxScheme: $facts)
}
