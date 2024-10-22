//
//  ScenarioView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//
import SwiftUI

struct ScenarioView : View {
    @Binding var document: TaxScenarioDocument
    @State var showAlert: Bool = false
    
    init(_ document: Binding<TaxScenarioDocument>) {
        self._document = document
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Header($document.scenario)
                KeyFigures($document.scenario)
                ProfileView($document.scenario)
                IncomeView($document.scenario)
                DeductionsView($document.scenario)
            }
            .padding()
        }
        .tint(Color.accentColor)
        .navigationTitle(document.scenario.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Alert") {
                    showAlert.toggle()
                }
            }
        }
        .alert(isPresented: $showAlert, error: AppErrors.unknownTaxFact("2025")) {
            Text("Alert Text Here!!")
        }
    }
}
