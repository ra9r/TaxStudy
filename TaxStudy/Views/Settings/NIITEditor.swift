//
//  NIITEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/28/24.
//

import SwiftUI

struct NIITEditor : View {
    @Binding var facts: TaxFacts
    
    var body: some View {
        ScrollView {
            TaxFactEditorContainer(
                "Net Investment Income Tax (NIIT)",
                description: "The Net Investment Income Tax (NIIT) is a tax on certain investment income for individuals, estates, and trusts. It applies to those with modified adjusted gross income (MAGI) above specific thresholds based on filing status.")
            {
                let gridItems = [
                    GridItem(.flexible(), alignment: .trailing),
                    GridItem(.flexible(), alignment: .leading)
                ]
                HStack {
                    LazyVGrid(columns: gridItems, spacing: 10) {
                        Text("Rate").font(.headline)
                        TextField("Value", value: $facts.niitRate, format: .percent)
                            .decorated(by: "percent")
                            .frame(maxWidth: 80)
                        
                        Text("").font(.headline)
                        Divider()
                        
                        Threashold(.single)
                        Threashold(.marriedFilingJointly)
                        Threashold(.marriedFilingSeparately)
                        Threashold(.headOfHousehold)
                        Threashold(.qualifiedWidow)
                    }
                    .padding()
                    .frame(maxWidth: 400)
                    Spacer()
                }
            }
            .padding()
        }
    }
    
    func Threashold(_ filingStatus: FilingStatus) -> some View {
        Group {
            Text(filingStatus.label).font(.headline)
            TextField("Value", value: $facts.niitThresholds[filingStatus], format: .number)
                .decorated(by: "dollarsign")
        }
    }
}

#Preview {
    @Previewable @State var facts: TaxFacts = createEmptyTaxFacts(id: "2024")
    NIITEditor(facts: $facts)
}
