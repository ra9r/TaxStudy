//
//  Header.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/15/24.
//

import SwiftUI

struct HeaderView: View {
    var allFacts: [TaxFacts]
    @Binding var scenario: TaxScenario
    
    var body: some View {
        let gridItems = [
            GridItem(.fixed(150), alignment: .leading),
            GridItem(.flexible(), alignment: .leading),
            GridItem(.fixed(200), alignment: .trailing),
        ]
        LazyVGrid(columns: gridItems) {
            PillBox
            NameAndDescription
            ConfigBox
        }
        .padding(.bottom, 20)
    }

    var PillBox: some View {
        VStack(alignment: .center, spacing: 0) {
            if let selectedFacts = allFacts.first(where: {$0.id == scenario.facts}) {
                Text("\(selectedFacts.year.noFormat)")
                    .font(.largeTitle)
                Text("\(selectedFacts.name)")
                    .font(.caption)
            } else {
                Text("???")
                    .font(.largeTitle)
                Text("--")
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .foregroundStyle(.white)
        .background(.accent)
        .cornerRadius(5)
        
    }
    
    var NameAndDescription: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("Scenario:")
                TextField("name", text: $scenario.name)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .font(.title)
            
            TextEditor(text: $scenario.description)
                .textEditorStyle(.plain)
                .scrollDisabled(true)
                .lineLimit(3)
                .font(.subheadline)
                .padding(.leading, -5) // <-- This seems like a hack :(
                .multilineTextAlignment(.leading)
        }
    }
    
    var ConfigBox: some View {
        VStack {
            Menu {
                ForEach(FilingStatus.allCases, id: \.self) { option in
                    Button("\(option.label)"){
                        scenario.filingStatus = option
                    }
                }
            } label: {
                Spacer()
                Text("\(scenario.filingStatus.label)")
                    .decorated(by: "chevron.down")
            }
            .buttonStyle(PlainButtonStyle())
            
            Menu {
                ForEach(allFacts, id: \.id) { taxFacts in
                    Button("\(taxFacts.year.noFormat) - \(taxFacts.name)"){
                        scenario.facts = taxFacts.id
                    }
                }
            } label: {
                Spacer()
                if let selectedFacts = allFacts.first(where: {$0.id == scenario.facts}) {
                    Text("\(selectedFacts.year.noFormat) - \(selectedFacts.name)")
                        .decorated(by: "chevron.down")
                } else {
                    Text("-- Select --")
                        .decorated(by: "chevron.down")
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity)
    }
}
