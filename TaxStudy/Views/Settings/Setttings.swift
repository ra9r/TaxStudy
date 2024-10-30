//
//  Se.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/20/24.
//
import SwiftUI

struct SettingsView : View {
    @Binding var facts: [TaxFacts]
    @State var selectedFacts: Int?
    
    
    var body: some View {
        NavigationSplitView {
            List(facts.indices, id: \.self,  selection: $selectedFacts) { index in
                NavigationLink("Facts: \(facts[index].id)", value: index)
            }
            .frame(minWidth: 200)
            .navigationTitle("Tax Facts")
        } detail: {
            if let selectedFacts {
                TaxFactsEditor(facts: $facts[selectedFacts])
            }
        }
        .onAppear {
            if selectedFacts == nil && facts.isEmpty == false {
                selectedFacts = 0
            }
        }
    }
}




#Preview(traits: .sizeThatFitsLayout) { 
    @Previewable @State var facts: [TaxFacts] = [TaxFacts.createNewTaxFacts(id: "2023"), TaxFacts.createNewTaxFacts(id: "2024")]
    SettingsView(facts: $facts)
}
