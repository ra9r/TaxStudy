//
//  TaxChart.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/14/24.
//

import SwiftUI
import Charts

struct BarSegment: Identifiable {
    let id = UUID()
    var name: String
    var value: Double
    var color: Color
}


struct TaxChart: View {
    var facts: [TaxScheme]
    var scenario: TaxScenario
    
    var body: some View {
        
        Chart {
            ForEach(segments()) { segment in
                BarMark(
                    x: .value("Amount", segment.value),
                    y: .value("Single Bar", "\(segment.name) (\(segment.value.asCurrency))")
                )
                .foregroundStyle(segment.color)
                .cornerRadius(5)
            }
        }
    }
    
    func segments() -> [BarSegment] {
        if let facts = facts.first(where: {$0.id == scenario.facts }) {
            let federalTaxes = FederalTaxCalc(scenario, taxScheme: facts)
            var data: [BarSegment] = []
            data.append(.init(name: "Capital Gains", value: federalTaxes.capitalGainsTax, color: .accent.opacity(0.8)))
            data.append(.init(name: "Qualified Dividends", value: federalTaxes.qualifiedDividendTax, color: .accent.opacity(0.7)))
            data.append(.init(name: "Ordinary Income", value: federalTaxes.ordinaryIncomeTax, color: .accent.opacity(0.6)))
            data.append(.init(name: "NIIT", value: federalTaxes.netInvestmentIncomeTax, color: .accent.opacity(0.5)))
            data.append(.init(name: "FICA", value: federalTaxes.totalFICATax, color: .accent.opacity(0.4)))
            data = data.sorted { $0.value > $1.value }
            
            return data
        } else {
            return []
        }
    }
    
}

