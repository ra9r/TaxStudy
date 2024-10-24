//
//  SideMenuView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/24/24.
//

import SwiftUI

struct ProjectView : View {
    @State var multiSelection = Set<Int>()
    @ObservedObject var appServices: AppServices
    
    @Binding var document: TaxProjectDocument
    
    init(_ document: Binding<TaxProjectDocument>) {
        _document = document
        _appServices = ObservedObject(wrappedValue: AppServices(document: document))
    }
    
    var body: some View {
        NavigationSplitView {
            // Sidebar showing a list of open documents
            List(selection: $multiSelection) {
                ForEach(appServices.document.scenarios.indices, id:\.self) { index in
                    let name = appServices.document.scenarios[index].name
                    NavigationLink(name, value: index)
                }
                .onMove(perform: move)
            }
            .navigationTitle("Documents")
        } detail: {
            if multiSelection.count == 1, let index = multiSelection.first {
                ScenarioView($appServices.document.scenarios[index])
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
        .environmentObject(appServices)
        .onAppear {
            appServices.document = document
        }
        
    }
    
    func move(from source: IndexSet, to destination: Int) {
        appServices.move(from: source, to: destination)
        multiSelection.removeAll()
    }
    
    
}
