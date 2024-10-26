//
//  SideMenuView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/24/24.
//

import SwiftUI

struct ProjectView : View {
    @State var showSettings: Bool = false
    @State var multiSelection = Set<Int>()
    @ObservedObject var projServices: ProjectServices
    
    @Binding var document: TaxProjectDocument
    
    init(_ document: Binding<TaxProjectDocument>) {
        _document = document
        _projServices = ObservedObject(wrappedValue: ProjectServices(document: document))
    }
    
    var body: some View {
        NavigationSplitView {
            // Sidebar showing a list of open documents
            List(selection: $multiSelection) {
                ForEach(projServices.document.scenarios.indices, id:\.self) { index in
                    let name = projServices.document.scenarios[index].name
                    NavigationLink(name, value: index)
                        .contextMenu {
                            if multiSelection.count == 1 {
                                Button("Duplicate") {
                                    projServices.duplicate(at: index)
                                }
                                Button("Delete", role: .destructive) {
                                    projServices.delete(at: index)
                                }
                            }
                        }
                }
                .onMove(perform: move)
            }
            .frame(minWidth: 200)
            
        } detail: {
            if multiSelection.count == 1, let index = multiSelection.first {
                ScenarioView($projServices.document.scenarios[index])
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
        .environmentObject(projServices)
        .toolbar {
            ToolbarItem(placement: .secondaryAction) {
                Button {
                    projServices.newScenario()
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
            
            ToolbarItem(placement: .status) {
                Button {
                    showSettings.toggle()
                } label: {
                    Image(systemName: "wrench.and.screwdriver")
                }
            }
        }
        .onAppear {
            projServices.document = document
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
                .frame(width: 1024, height: 500)
                .environmentObject(projServices)
        }
        
    }
    
    func move(from source: IndexSet, to destination: Int) {
        // Track the actual selected items before the move
        let selectedItems = multiSelection.map { projServices.document.scenarios[$0].name }
        
        // Perform the move in the document
        projServices.move(from: source, to: destination)
        
        // Update multiSelection by finding the new indices of the previously selected items
        multiSelection = Set(selectedItems.compactMap { name in
            projServices.document.scenarios.firstIndex(where: { $0.name == name })
        })
    }
    
    
}
