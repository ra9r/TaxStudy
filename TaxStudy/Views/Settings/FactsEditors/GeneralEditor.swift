//
//  GeneralEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/5/24.
//

import SwiftUI

struct GeneralEditor : View {
    @Binding var facts: TaxFacts
    
    var body: some View {
        DescribedContainer(
            "General Infomation",
            description: "This is the general information about these Tax Facts that help identify the year its designed for and any other notes.")
        {
            let gridItems = [
                GridItem(.fixed(100), alignment: .topTrailing),
                GridItem(.flexible(), alignment: .leading),
            ]
            
            LazyVGrid(columns: gridItems, spacing: 10) {
                Text("Name").font(.headline)
                TextField("Name", text: $facts.id)
                    .decorated(by: "info.circle")
                    .frame(maxWidth: 200)
                Text("Notes").font(.headline)
                TextEditor(text: $facts.notes)
                    .decorated()
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var facts: TaxFacts = TaxFacts.official2024
    GeneralEditor(facts: $facts)
}
