//
//  ContentView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var scenario: TaxScenario = TaxScenario()

    var body: some View {
        NavigationSplitView {
            List {
                Text("Scenario")
            }
        } content: {
            ScenarioEditor(scenario: $scenario)
        } detail: {
            ResultsView(scenario: scenario)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    

    
}

#Preview {
    ContentView()
}
