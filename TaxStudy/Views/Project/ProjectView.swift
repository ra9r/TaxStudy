//
//  SideMenuView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/24/24.
//

import SwiftUI

struct ProjectView : View {
    @State var multiSelection = Set<Int>()
    @State var appServices: AppServices = AppServices()
    
    @Binding var document: TaxProjectDocument
    
    init(_ document: Binding<TaxProjectDocument>) {
        _document = document
    }
    
    var body: some View {
        @Bindable var services = appServices
        NavigationSplitView {
            // Sidebar showing a list of open documents
            List(appServices.scenarios.indices, id:\.self, selection: $multiSelection) { index in
                NavigationLink("\(appServices.scenarios[index].name)", value: index)
            }
            .navigationTitle("Documents")
        } detail: {
            if multiSelection.count == 1, let index = multiSelection.first {
                ScenarioView($services.scenarios[index])
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
        .environment(appServices)
        .onAppear {
            appServices.facts = document.content.facts
            appServices.scenarios.append(contentsOf: document.content.scenarios)
        }
        
    }
}
