//
//  ReportItem.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/13/24.
//
import SwiftUI

class ReportItem : Codable, Identifiable {
    var id: String
    var type: ReportItemType
    
    var label: String {
        switch type {
        case .keyMetric(let keyMetric):
            return keyMetric.label
        case .divider:
            return ""
        }
    }
    
    init(_ id: String? = nil, type: ReportItemType) {
        self.type = type
        self.id = id ?? UUID().uuidString
    }
    
    @ViewBuilder
    func content(scenario: TaxScenario, taxScheme: TaxScheme, compact: Bool = false) -> some View {
        let federalTaxes = FederalTaxCalc(scenario, taxScheme: taxScheme)
        let stateTaxes = NCTaxCalc(scenario, taxScheme: taxScheme)
        switch type {
        case .keyMetric(let keyMetric):
            CardItem(keyMetric.label, value: keyMetric.resolve(fedTax: federalTaxes, stateTax: stateTaxes), compact: compact)
        case .divider:
            Divider()
                .padding(5)
        }
    }
}

extension ReportItem: Equatable {
    static func == (lhs: ReportItem, rhs: ReportItem) -> Bool {
        return lhs.id == rhs.id
    }
}

