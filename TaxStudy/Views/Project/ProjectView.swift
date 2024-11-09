//
//  SideMenuView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/24/24.
//

import SwiftUI
import KeyWindow

struct ProjectView : View {
    @Environment(TaxFactsManager.self) var taxFactsManager
    @Binding var document: TaxProjectDocument
    @State var multiSelection = Set<Int>()
    
    
    init(_ document: Binding<TaxProjectDocument>) {
        _document = document
    }
    
    var body: some View {
        NavigationSplitView {
            SideMenu(scenarios: $document.scenarios,
                     embeddedFacts: document.facts,
                     multiSelection: $multiSelection)
            
        } detail: {
            if multiSelection.count == 1, let index = multiSelection.first {
                ScenarioView(scenario: $document.scenarios[index], embeddedFacts: document.facts)
            } else if multiSelection.count >= 1{
                ContentUnavailableView("Compare Feature Not Available",
                                       systemImage: "wrench.and.screwdriver.fill",
                                       description: Text("This feature is still a work in progress"))
            } else {
                ContentUnavailableView("Please select a Tax Scenario",
                                       systemImage: "wrench.and.screwdriver.fill",
                                       description: Text("You'll need to select a tax scenario to beign editing."))
            }
        }
        .frame(minWidth: 1100)
        .keyWindow(TaxProjectDocument.self, $document)        
    }
}
