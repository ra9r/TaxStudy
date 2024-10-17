//
//  TaxBracketEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/16/24.
//

import SwiftUI

struct TaxBracketEditor: View {
    @State var filingStatus: FilingStatus // The selected filing status
    var taxBrackets: TaxBrackets
    @State var selection: Set<TaxBracket.ID> = []
    var body: some View {
        VStack {
            Text("Edit Tax Brackets for \(filingStatus.rawValue)")
                .font(.headline)
            
            Table(taxBrackets.brackets, selection: $selection) {
                TableColumn("Tax Rate", value: \.rate.asPercentage)
                TableColumn("Income Threadhold") { bracket in
                    Text(bracket.threshold.asCurrency)
                }
            }
            
            // Add New Tax Bracket Button
            Button(action: {
                print("Clicked!")
            }) {
                Text("Add New Tax Bracket")
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var manager = TaxScenarioManager()
    TaxBracketEditor(filingStatus: .single, taxBrackets: manager.selectedTaxScenario.facts.ordinaryTaxBrackets[.single]!)
        .environment(manager)
}
