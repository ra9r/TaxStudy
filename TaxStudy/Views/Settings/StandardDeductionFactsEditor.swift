//
//  StandardDeductionFacts.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/28/24.
//

import SwiftUI

struct StandardDeductionFactsEditor : View {
    @Binding var facts: TaxFacts
    
    var body: some View {
        ScrollView {
            DescribedContainer(
                "Standard Deductions",
                description: "The standard deduction is a fixed amount that reduces your taxable income, allowing you to lower the amount of income on which you pay taxes. Additionally, taxpayers above the 'Bonus Age' or older can receive an extra deduction based on their filing status.")
            {
                let gridItems = [
                    GridItem(.flexible(), alignment: .trailing),
                    GridItem(.flexible(), alignment: .leading),
                    GridItem(.flexible(), alignment: .leading)
                ]
                
                LazyVGrid(columns: gridItems, spacing: 10) {
                    Text("Bonus Age").font(.headline)
                    TextField("Value", value: $facts.standardDeductionBonusAge, format: .number)
                        .decorated(by: "person.crop.circle")
                        .frame(maxWidth: 80)
                    Text("")
                    
                    Text("").font(.headline)
                    Divider()
                    Divider()
                    
                    Text("")
                    Text("Deduction Amt").font(.headline)
                    Text("Deduction Bonus").font(.headline)
                    
                    DeductionRow(.single)
                    DeductionRow(.marriedFilingJointly)
                    DeductionRow(.marriedFilingSeparately)
                    DeductionRow(.headOfHousehold)
                    DeductionRow(.qualifiedWidow)
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .padding()
        }
    }
    
    func DeductionRow(_ filingStatus: FilingStatus) -> some View {
        Group {
            Text(filingStatus.label).font(.headline)
            TextField("Value", value: $facts.standardDeduction[filingStatus], format: .number)
                .decorated(by: "dollarsign")
            TextField("Value", value: $facts.standardDeductionBonus[filingStatus], format: .number)
                .decorated(by: "dollarsign")
        }
    }
}

#Preview {
    @Previewable @State var facts: TaxFacts = TaxFacts.official2024
    StandardDeductionFactsEditor(facts: $facts)
}
