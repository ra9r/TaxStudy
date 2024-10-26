//
//  SideMenu.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/25/24.
//

import SwiftUI

struct SideMenu: View {
    @State var showSettings: Bool = false
    @Binding var facts: [TaxFacts]
    @Binding var scenarios: [TaxScenario]
    @Binding var multiSelection: Set<Int>
    
    var body: some View {
        // Sidebar showing a list of open documents
        List(selection: $multiSelection) {
            ForEach(scenarios.indices, id:\.self) { index in
                let name = scenarios[index].name
                NavigationLink(name, value: index)
                    .contextMenu {
                        if multiSelection.count == 1 {
                            Button("Duplicate") {
                                duplicate(at: index)
                            }
                            Button("Delete", role: .destructive) {
                                delete(at: index)
                            }
                        }
                    }
            }
            .onMove(perform: move)
        }
        .frame(minWidth: 200)
        .toolbar {
            ToolbarItem(placement: .secondaryAction) {
                Button {
                    newScenario()
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
        .sheet(isPresented: $showSettings) {
            SettingsView(facts: $facts)
                .frame(width: 1024, height: 500)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        // Track the actual selected items before the move
        let selectedItems = multiSelection.map { scenarios[$0].name }
        
        // Perform the move in the document
        scenarios.move(fromOffsets: source, toOffset: destination)
        
        // Update multiSelection by finding the new indices of the previously selected items
        multiSelection = Set(selectedItems.compactMap { name in
            scenarios.firstIndex(where: { $0.name == name })
        })
    }
    
    func newScenario() {
        guard let firstFact = facts.first else {
            fatalError("Unabled to create new TaxScenario, no TaxFacts found")
        }
        let newScenario = TaxScenario(name: "New Scenario", facts: firstFact.id)
        
       scenarios.append(newScenario)
    }
    
    func delete(at selectedIndex: Int) {
        scenarios.remove(at: selectedIndex)
    }
    
    func duplicate(at selectedIndex: Int) {
        let scenario = scenarios[selectedIndex]
        
        scenarios.append(scenario.deepCopy)
    }
}
