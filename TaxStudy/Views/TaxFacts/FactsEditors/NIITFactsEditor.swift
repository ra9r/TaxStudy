//
//  NIITEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/28/24.
//

import SwiftUI

struct NIITFactsEditor : View {
    @Binding var taxScheme: TaxScheme
    
    var body: some View {
        ScrollView {
            DescribedContainer(
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
                        TextField("Value", value: $taxScheme.niitRate, format: .percent)
                            .decorated(by: "percent")
                            .frame(maxWidth: 80)
                        
                        Text("").font(.headline)
                        Divider()
                        
                        ThresholdEditor(thresholds: $taxScheme.niitThresholds)
                    }
                    .padding()
                    .frame(maxWidth: 400)
                    Spacer()
                }
                
                
                .padding()
            }
            .padding()
        }
    }
}



#Preview {
    @Previewable @State var facts: TaxScheme = TaxScheme.official2024
    NIITFactsEditor(taxScheme: $facts)
}
