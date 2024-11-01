//
//  OrdinaryFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/31/24.
//
import SwiftUI

struct FICAFactsEditor : View {
    @Binding var facts: TaxFacts
    
    var body: some View {
        ScrollView {
            DescribedContainer(
                "FICA Thresholds",
                description: "The Federal Insurance Contributions Act (FICA) tax comprises two components: Social Security and Medicare taxes")
            {
                Text("Social Security Thresholds")
                    .font(.title2)
                    .padding(.vertical)
                
                TaxBracketEditor(taxBrackets: $facts.ssTaxThresholds)
                
                Text("Medicare Thresholds")
                    .font(.title2)
                    .padding(.vertical)
                
                TaxBracketEditor(taxBrackets: $facts.medicareTaxThresholds)
                    
            }
        }
        .padding()
    }
}


#Preview {
    @Previewable @State var facts: TaxFacts = TaxFacts.official2024
    FICAFactsEditor(facts: $facts)
}
