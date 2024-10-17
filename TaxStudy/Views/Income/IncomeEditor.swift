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
            ForEach(incomeSources.matching(anyOf: incomeTypes), id: \.self) { incomeSource in
                CardItem(incomeSource.type.label,
                         value: incomeSource.amount.asCurrency)
                .contextMenu {
                    Button("Delete") {
                        incomeSources.remove(incomeSource)
                    }
                }
                
//                if index != incomeSources.sources.indices.last {
                    Divider()
//                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
