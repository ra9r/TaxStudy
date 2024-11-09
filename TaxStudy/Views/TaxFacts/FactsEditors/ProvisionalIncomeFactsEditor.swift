//
//  ProvisionalIncomeFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/1/24.
//

import SwiftUI

struct ProvisionalIncomeFactsEditor : View {
    @Binding var taxScheme: TaxScheme
    
    var body: some View {
        ScrollView {
            DescribedContainer(
                "Social Security Tax",
                description: "Provisional income thresholds are income limits set by the IRS that determine whether and how much of your Social Security benefits may be taxable. Provisional income includes adjusted gross income (AGI), tax-exempt interest, and 50% of Social Security benefits.")
            {
                TaxBracketEditor(taxBrackets: $taxScheme.provisionalIncomeThresholds)
                    
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var taxFactService = TaxSchemeManager()
    TaxSchemeFactListView(taxScheme: $taxFactService.officialSchemes[0], selectedSetting: .provisionalIncomeThresholds)
}
