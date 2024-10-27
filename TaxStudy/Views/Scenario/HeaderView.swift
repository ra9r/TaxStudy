//
//  Header.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/15/24.
//

import SwiftUI

struct HeaderView: View {
    var facts: [TaxFacts]
    @Binding var scenario: TaxScenario
    
    var body: some View {
        HStack(alignment: .top, spacing: 25) {
            blueBox
            nameAndDescription
            VStack {
                Picker("Filing Status", selection: $scenario.filingStatus) {
                    ForEach(FilingStatus.allCases, id: \.label) { status in
                        Text(status.label).tag(status)
                    }
                }
                Picker("Tax Facts", selection: $scenario.facts) {
                    ForEach(facts, id: \.id) { taxFacts in
                        Text(taxFacts.id).tag(taxFacts.id)
                    }
                }
            }
            Spacer()
        }
        .padding(.bottom, 20)
    }
    
    var grossIncome: Double {
        guard let fact = facts.first(where: { $0.id == scenario.facts }) else {
            fatalError("No tax facts found with id: '\(scenario.facts)'")
        }
        return FederalTaxCalc(scenario, facts: fact).grossIncome
    }
    
    var blueBox: some View {
        HStack {
            Text(scenario.facts)
                .font(.largeTitle)
            Divider()
            VStack(alignment: .trailing) {
                Text("\(grossIncome.asCurrency)")
                    .font(.headline)
                Text("Gross Income")
                    .font(.subheadline)
            }
        }
        .frame(minWidth: 200)
        .padding()
        .foregroundStyle(.white)
        .background(.accent)
        .cornerRadius(5)
    }
    
    var nameAndDescription: some View {
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
}

