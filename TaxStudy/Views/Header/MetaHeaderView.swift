//
//  MetaHeaderView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/13/24.
//
import SwiftUI

struct MetaHeaderView : View {
    var federalTaxes: FederalTaxCalc
    var stateTaxes: StateTaxCalc
    
    init(_ scenario: TaxScenario, facts: TaxFacts? = nil) {
        self.federalTaxes = FederalTaxCalc(scenario, facts: facts)
        self.stateTaxes = NCTaxCalc(scenario, facts: facts) // TODO: Refactor to support any state
    }
    
    var body: some View {
//        // Define grid layout to create flexible wrapping
//        let layout = [
//            // .adaptive adjusts the item size to fit the available width
//            GridItem(.adaptive(minimum: 200)) // minimum width for each card
//        ]
//        
//        LazyVGrid(columns: layout, alignment: .leading, spacing: 5) {
//            MetaCard(
//                symbolName: federalTaxes.scenario.filingStatus.symbol,
//                label: "Filing Status",
//                value: "\(federalTaxes.scenario.filingStatus.rawValue)"
//            )
//            MetaCard(
//                symbolName: "briefcase",
//                label: "Employment Status",
//                value: "\(federalTaxes.scenario.employmentStatus.rawValue)"
//            )
//            MetaCard(
//                symbolName: "scissors",
//                label: "\(federalTaxes.deductionMethod)",
//                value: "\(federalTaxes.deduction.asCurrency)"
//            )
//            MetaCard(
//                symbolName: "exclamationmark",
//                label: "Subject to NIIT",
//                value: "\(federalTaxes.isSubjectToNIIT)"
//            )
//            MetaCard(
//                symbolName: "building.columns",
//                label: "Federal Taxes",
//                value: "\(federalTaxes.taxesOwed.asCurrency) (\(federalTaxes.effectiveTaxRate.asPercentage))"
//            )
//            MetaCard(
//                symbolName: "map",
//                label: "State Taxes",
//                value: "\(stateTaxes.taxesOwed.asCurrency) (\(stateTaxes.effectiveTaxRate.asPercentage))"
//            )
//            Spacer()
//        }
//        .padding(.bottom, 5)
        KeyFigures(federalTaxes: federalTaxes)
    }
}
