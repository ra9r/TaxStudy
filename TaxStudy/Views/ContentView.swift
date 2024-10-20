//
//  ContentView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(AppServices.self) var services
    @State var activeScenario: TaxScenario?
    
    var body: some View {
        NavigationSplitView {
            SidebarView($activeScenario)
        } detail: {
            if let activeScenario {
                ScenarioView(Binding($activeScenario)!)
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AppData())
}


