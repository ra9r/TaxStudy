//
//  SideMenuView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/24/24.
//

import SwiftUI

struct ProjectView : View {
    
    @Binding var document: TaxProjectDocument
    @State var multiSelection = Set<Int>()
    
    
    init(_ document: Binding<TaxProjectDocument>) {
        _document = document
    }
    
    var body: some View {
        NavigationSplitView {
            SideMenu(facts: $document.facts,
                     scenarios: $document.scenarios,
                     multiSelection: $multiSelection)
            
        } detail: {
            if multiSelection.count == 1, let index = multiSelection.first {
                ScenarioView(facts: document.facts, scenario: $document.scenarios[index])
            } else if multiSelection.count >= 1{
                ContentUnavailableView("Compare Feature Not Available",
                                       systemImage: "wrench.circle",
                                       description: Text("This feature is still a work in progress"))
            } else {
                ContentUnavailableView("Please select a Tax Scenario",
                                       systemImage: "square.dashed",
                                       description: Text("You'll need to select a tax scenario to beign editing."))
            }
        }
        .frame(minWidth: 1100)
    }
}
