//
//  ProvisionalIncomeFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/1/24.
//

import SwiftUI

struct ProvisionalIncomeFactsEditor : View {
    @Binding var facts: TaxFacts
    
    var body: some View {
        ScrollView {
            DescribedContainer(
                "Social Security Tax",
                description: "Provisional income thresholds are income limits set by the IRS that determine whether and how much of your Social Security benefits may be taxable. Provisional income includes adjusted gross income (AGI), tax-exempt interest, and 50% of Social Security benefits.")
            {
                TaxBracketEditor(taxBrackets: $facts.provisionalIncomeThresholds)
                    
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var taxFactService = TaxFactsManager()
    TaxFactsEditor(facts: $taxFactService.officialFacts[0], selectedSetting: .provisionalIncomeThresholds)
}
