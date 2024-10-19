//
//  ContentView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        NavigationSplitView {
            SidebarView()
            
        } detail: {
            ScenarioView()
                
        }
    }
}

#Preview {
    ContentView()
        .environment(TaxScenarioManager())
}


