//
//  ContentView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var scenario: TaxScenario
    @State private var isModalPresented = false
    
    init() {
        self.scenario = TaxScenario()
        self.scenario.socialSecuritySelf = 32154.82
        self.scenario.interest = 12250.00
        self.scenario.capitalLossCarryOver = 2000000.00
        self.scenario.qualifiedDividends = 130950.00
        self.scenario.filingStatus = .marriedFilingJointly
        self.scenario.ordinaryTaxBrackets = TaxBrackets([.marriedFilingJointly: [.init(0, 0.10), .init(11600, 0.12), .init(47150, 0.22), .init(100525, 0.24), .init(191950, 0.32), .init(243725, 0.35), .init(609350, 0.37)]])
        self.scenario.capitalGainTaxBrackets = TaxBrackets([.marriedFilingJointly: [.init(0, 0), .init(89250, 0.15), .init(553850, 0.2)]])
    }

    var body: some View {
        NavigationSplitView {
            List {
                Text("Scenario")
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
//                        isModalPresented.toggle()
                        print("Clicked!")
                    }) {
                        Label("Add Scenario", systemImage: "plus")
                    }
                }
            }
        } detail: {
            ScenarioResults(scenario: scenario)
            TabView {
                // First Tab
                Text("Overview Tab Content")
                    .tabItem {
                        Label("Overview", systemImage: "house.fill")
                    }

                // Second Tab
                ScenarioEditor(scenario: $scenario)
                    .tabItem {
                        Label("Income", systemImage: "gearshape.fill")
                    }

                // Third Tab
                Text("Deductions Tab Content")
                    .tabItem {
                        Label("Deductions", systemImage: "person.crop.circle.fill")
                    }
                Text("Rates Tab Content")
                    .tabItem {
                        Label("Rates", systemImage: "person.crop.circle.fill")
                    }
            }
            .toolbar {
                        // Add a button to the title bar's trailing side (right side)
                        ToolbarItem(placement: .navigation) {
                            Button(action: {
                                print("Button clicked!")
                            }) {
                                Label("Refresh", systemImage: "arrow.clockwise")
                            }
                        }
                    }
        }
        
        .sheet(isPresented: $isModalPresented) {
            ScenarioEditor(scenario: $scenario)
                .frame(minWidth: 300)
                .padding()
        }
    }
    
}

#Preview {
    ContentView()
}
