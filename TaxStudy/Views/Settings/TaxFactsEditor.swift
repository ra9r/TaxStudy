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
        case .standardDeductions:
            StandardDeductionFactsEditor(facts: $facts)
        case .ordinaryTaxBrackets:
            OrdinaryFactsEditor(facts: $facts)
        case .capitalGainsTaxBrackets:
            CapitalGainFactsEditor(facts: $facts)
        case .ficaTaxThresholds:
            FICAFactsEditor(facts: $facts)
        case .medicareTaxThresholds:
            TaxBracketEditor(taxBrackets: $facts.medicareTaxThresholds)
        case .provisionalIncomeThresholds:
            TaxBracketEditor(taxBrackets: $facts.provisionalIncomeThresholds)
        case .hsaLimits:
            Text("HSA Limits")
        case .iraLimits:
            Text("IRA Limits")
        case .irmaaSurcharges:
            Text("IRMAA Surcharges")
        case .niiTax:
            NIITFactsEditor(facts: $facts)
        case .charitableDeductions:
            Text("Charitable Deductions")
        case .earmingsLimits:
            Text("Earning Limits for SSA Income")
        }
    }
}

#Preview {
    @Previewable @State var taxFactService = TaxFactsManager()
    TaxFactsEditor(facts: $taxFactService.officialFacts[0], selectedSetting: .capitalGainsTaxBrackets)
}
