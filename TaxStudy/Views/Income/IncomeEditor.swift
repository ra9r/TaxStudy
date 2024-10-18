//
//  ScenarioEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/28/24.
//

import SwiftUI

//
//  ScenarioEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/28/24.
//

import SwiftUI

struct IncomeEditor: View {
    var title: String
    var incomeTypes: [IncomeType]
    @Binding var incomeSources: IncomeSources
    @State private var showDescription: Bool = false
    @State private var amount: Double = 0
    
    init(_ title: String, _ sources: Binding<IncomeSources>, filter: [IncomeType]? = nil) {
        self.title = title
        self.incomeTypes = filter ?? IncomeType.allCases
        self._incomeSources = sources
    }
    
    var body: some View {
        CardView {
            HStack {
                Text(title)
                
                Spacer()
                Menu {
                    ForEach(incomeTypes, id: \.self) { incomeType in
                        Button(incomeType.label) {
                            incomeSources.add(.init(incomeType, amount: 0))
                        }
                    }
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .buttonStyle(PlainButtonStyle())
            }
        } content: {
            // Filter the sources based on incomeTypes
            let filteredSources = incomeSources.sources.filter { incomeTypes.contains($0.type) }
            
            // Iterate through the filtered sources
            ForEach(filteredSources.indices, id: \.self) { index in
                CardField(filteredSources[index].type.label,
                          amount: $incomeSources.sources[incomeSources.sources.firstIndex(where: { $0.id == filteredSources[index].id })!].amount)
                .help(filteredSources[index].type.description)
                .contextMenu {
                    Button("Delete") {
                        incomeSources.remove(filteredSources[index])
                    }
                }
                
                // Only show the divider if it's not the last visible item
                if index != filteredSources.indices.last {
                    Divider()
                }
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
