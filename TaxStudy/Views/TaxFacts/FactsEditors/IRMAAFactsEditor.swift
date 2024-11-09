//
//  IRMAAFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/1/24.
//

import SwiftUI

struct IRMAAPartBFactsEditor : View {
    @Binding var taxScheme: TaxScheme
    
    var body: some View {
        DescribedContainer(
            "IRMAA Part B Surcharge Thresholds",
            description: "IRMAA (Income-Related Monthly Adjustment Amount) thresholds determine whether Medicare beneficiaries with higher incomes must pay an additional premium for Medicare Parts B.")
        {
            TaxBracketEditor(taxBrackets: $taxScheme.irmaaPlanBThresholds, style: .number)
        }
        .padding()
    }
    
}

struct IRMAAPartDFactsEditor : View {
    @Binding var taxScheme: TaxScheme
    
    var body: some View {
        DescribedContainer(
            "IRMAA Part D Surcharge Thresholds",
            description: "IRMAA (Income-Related Monthly Adjustment Amount) thresholds determine whether Medicare beneficiaries with higher incomes must pay an additional premium for Medicare Parts D.")
        {
            TaxBracketEditor(taxBrackets: $taxScheme.irmaaPlanDThresholds, style: .number)
        }
        .padding()
    }
    
}

#Preview {
    @Previewable @State var taxFactService = TaxSchemeManager()
    TaxSchemeFactListView(taxScheme: $taxFactService.officialSchemes[0], selectedSetting: .irmaaPartBSurcharges)
}

#Preview {
    @Previewable @State var taxFactService = TaxSchemeManager()
    TaxSchemeFactListView(taxScheme: $taxFactService.officialSchemes[0], selectedSetting: .irmaaPartDSurcharges)
}
