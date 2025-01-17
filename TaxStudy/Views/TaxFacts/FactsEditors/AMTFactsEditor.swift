//
//  AMTFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/1/24.
//

import SwiftUI

struct AMTFactsEditor : View {
    @Binding var taxScheme: TaxScheme
    
    var body: some View {
        ScrollView {
            DescribedContainer(
                "Alternative Minimum Tax (AMT)",
                description: "")
            {
                let gridItems = [
                    GridItem(.flexible(), alignment: .trailing),
                    GridItem(.flexible(), alignment: .leading),
                    GridItem(.flexible(), alignment: .leading)
                ]
                
                LazyVGrid(columns: gridItems, spacing: 10) {
                    Text("AMT Reduction Rate").font(.headline)
                    TextField("Value", value: $taxScheme.amtExemptionReductionRate, format: .number)
                        .decorated(by: "person.crop.circle")
                        .frame(maxWidth: 80)
                    Text("")

                    Text("").font(.headline)
                    Divider()
                    Divider()
                    
                    Text("")
                    Text("Exemption Thresholds").font(.headline)
                    Text("Phase Out Thresholds").font(.headline)
                    
                    DeductionRow(.single)
                    DeductionRow(.marriedFilingJointly)
                    DeductionRow(.marriedFilingSeparately)
                    DeductionRow(.headOfHousehold)
                    DeductionRow(.qualifiedWidow)
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                Divider()
                
                Text("AMT Tax Brackets").font(.title).fontWeight(.bold)
                TaxBracketEditor(taxBrackets: $taxScheme.amtBrackets)
            }
            .padding()
        }
    }
    
    func DeductionRow(_ filingStatus: FilingStatus) -> some View {
        Group {
            Text(filingStatus.label).font(.headline)
            TextField("Value", value: $taxScheme.amtExemptions[filingStatus], format: .number)
                .decorated(by: "dollarsign")
            TextField("Value", value: $taxScheme.amtPhaseOutThesholds[filingStatus], format: .number)
                .decorated(by: "dollarsign")
        }
    }
}

#Preview {
    @Previewable @State var facts: TaxScheme = TaxScheme.official2024
    AMTFactsEditor(taxScheme: $facts)
}
