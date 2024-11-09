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
        HStack(alignment: .top, spacing: 25) {
            BlueBox
            NameAndDescription
            ConfigBox
        }
        .padding(.bottom, 20)
    }
    
//    var grossIncome: Double {
//        return FederalTaxCalc(scenario, facts: facts).grossIncome
//    }
    
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
                    Button("\(taxFacts.id)"){
                        scenario.facts = taxFacts.id
                    }
                }
            } label: {
                Spacer()
                Text("\(scenario.facts)")
                    .decorated(by: "chevron.down")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: 200)
    }
    
    var BlueBox: some View {
        HStack {
            Text(scenario.facts)
                .font(.largeTitle)
//            Divider()
//            VStack(alignment: .trailing) {
//                Text("\(grossIncome.asCurrency)")
//                    .font(.headline)
//                Text("Gross Income")
//                    .font(.subheadline)
//            }
        }
        .frame(minWidth: 200)
        .padding()
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
}
