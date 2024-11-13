//
//  ReportItem.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/13/24.
//
import SwiftUI

protocol ReportItem : Codable, Identifiable {
    var id: String { get }
    var type: String { get }
    associatedtype Content: View
    @ViewBuilder func content(scenario: TaxScenario, taxScheme: TaxScheme) -> Content
}

struct KeyMetricReportItem : ReportItem {
    var id: String
    var type: String = "KeyMetric"
    var keyMetric: KeyMetricTypes
    
    init(_ keyMetric: KeyMetricTypes) {
        self.id = UUID().uuidString
        self.keyMetric = keyMetric
    }
    
    @ViewBuilder func content(scenario: TaxScenario, taxScheme: TaxScheme) -> some View {
        let federalTaxes = FederalTaxCalc(scenario, taxScheme: taxScheme)
        let stateTaxes = NCTaxCalc(scenario, taxScheme: taxScheme)
        
        CardItem(keyMetric.label, value: keyMetric.resolve(fedTax: federalTaxes, stateTax: stateTaxes))
    }
}

struct DividerReportItem : ReportItem {
    var id: String
    var type: String = "Divider"
    
    init() {
        self.id = UUID().uuidString
    }
    
    @ViewBuilder func content(scenario: TaxScenario, taxScheme: TaxScheme) -> some View {
        Divider()
    }
}
