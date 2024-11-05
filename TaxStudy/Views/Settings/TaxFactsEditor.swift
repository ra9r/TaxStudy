//
//  TaxFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/29/24.
//
import SwiftUI



struct TaxFactsEditor : View {
    @Binding var facts: TaxFacts
    var selectedSetting: TaxFactsEditorTypes
    
    var body: some View {
        switch selectedSetting {
        case .generalInformation:
            GeneralEditor(facts: $facts)
        case .standardDeductions:
            StandardDeductionFactsEditor(facts: $facts)
        case .ordinaryTaxBrackets:
            OrdinaryFactsEditor(facts: $facts)
        case .capitalGainsTaxBrackets:
            CapitalGainFactsEditor(facts: $facts)
        case .ficaTaxThresholds:
            FICAFactsEditor(facts: $facts)
        case .provisionalIncomeThresholds:
            ProvisionalIncomeFactsEditor(facts: $facts)
        case .irmaaPartBSurcharges:
            IRMAAPartBFactsEditor(facts: $facts)
        case .irmaaPartDSurcharges:
            IRMAAPartDFactsEditor(facts: $facts)
        case .niiTax:
            NIITFactsEditor(facts: $facts)
        case .amtfacts:
            AMTFactsEditor(facts: $facts)
        }
    }
}

#Preview {
    @Previewable @State var taxFactService = TaxFactsManager()
    TaxFactsEditor(facts: $taxFactService.officialFacts[0], selectedSetting: .capitalGainsTaxBrackets)
}
