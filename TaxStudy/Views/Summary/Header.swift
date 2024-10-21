//
//  Header.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/15/24.
//

import SwiftUI

struct Header: View {
    @Environment(AppServices.self) var appServices
    @Binding var scenario: TaxScenario
    
    init(_ scenario: Binding<TaxScenario>) {
        self._scenario = scenario
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 25) {
            blueBox
            nameAndDescription
            Spacer()
        }
        .padding(.bottom, 20)
    }
    
    var grossIncome: Double {
        guard let facts = appServices.facts[scenario.facts] else { return 0 }
        return FederalTaxCalc(scenario, facts: facts).grossIncome
    }
    
    var blueBox: some View {
        HStack {
            Text("2024")
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

