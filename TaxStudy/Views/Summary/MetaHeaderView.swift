//
//  MetaHeaderView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/13/24.
//
import SwiftUI

struct MetaHeaderView : View {
    var ts: TaxScenario
    
    init(_ ts: TaxScenario) {
        self.ts = ts
    }
    
    var body: some View {
        // Define grid layout to create flexible wrapping
        let layout = [
            // .adaptive adjusts the item size to fit the available width
            GridItem(.adaptive(minimum: 200)) // minimum width for each card
        ]
        
        LazyVGrid(columns: layout, alignment: .leading, spacing: 5) {
            MetaCard(
                symbolName: ts.filingStatus.symbol,
                label: "Filing Status",
                value: "\(ts.filingStatus.rawValue)"
            )
            MetaCard(
                symbolName: "briefcase",
                label: "Employment Status",
                value: "\(ts.employmentStatus.rawValue)"
            )
            MetaCard(
                symbolName: "scissors",
                label: "Deduction Method",
                value: "\(ts.federalTaxes.deductionMethod)"
            )
            MetaCard(
                symbolName: "exclamationmark",
                label: "Subject to NIIT",
                value: "\(ts.federalTaxes.isSubjectToNIIT)"
            )
            MetaCard(
                symbolName: "building.columns",
                label: "Federal Taxes",
                value: "\(ts.federalTaxes.taxesOwed.asCurrency) (\(ts.federalTaxes.effectiveTaxRate.asPercentage))"
            )
            MetaCard(
                symbolName: "map",
                label: "State Taxes",
                value: "\(ts.stateTaxes.taxesOwed.asCurrency) (\(ts.stateTaxes.effectiveTaxRate.asPercentage))"
            )
            MetaCard(
                symbolName: "percent",
                label: "Effective Tax Rate",
                value: "\(ts.totalEffectiveTaxRate.asPercentage)"
            )
            Spacer()
        }
        .padding(.bottom, 5)
    }
}
