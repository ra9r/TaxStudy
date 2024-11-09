//
//  TaxFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/29/24.
//
import SwiftUI



struct TaxSchemeFactListView : View {
    @Binding var taxScheme: TaxScheme
    var selectedSetting: TaxSchemeFactTypes
    
    var body: some View {
        switch selectedSetting {
        case .generalInformation:
            GeneralEditor(taxScheme: $taxScheme)
        case .standardDeductions:
            StandardDeductionFactsEditor(taxScheme: $taxScheme)
        case .ordinaryTaxBrackets:
            OrdinaryFactsEditor(taxScheme: $taxScheme)
        case .capitalGainsTaxBrackets:
            CapitalGainFactsEditor(taxScheme: $taxScheme)
        case .ficaTaxThresholds:
            FICAFactsEditor(taxScheme: $taxScheme)
        case .provisionalIncomeThresholds:
            ProvisionalIncomeFactsEditor(taxScheme: $taxScheme)
        case .irmaaPartBSurcharges:
            IRMAAPartBFactsEditor(taxScheme: $taxScheme)
        case .irmaaPartDSurcharges:
            IRMAAPartDFactsEditor(facts: $taxScheme)
        case .niiTax:
            NIITFactsEditor(taxScheme: $taxScheme)
        case .amtfacts:
            AMTFactsEditor(taxScheme: $taxScheme)
        }
    }
}

#Preview {
    @Previewable @State var taxFactService = TaxSchemeManager()
    TaxSchemeFactListView(taxScheme: $taxFactService.officialSchemes[0], selectedSetting: .capitalGainsTaxBrackets)
}
