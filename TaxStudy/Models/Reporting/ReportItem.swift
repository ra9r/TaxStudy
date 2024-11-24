//
//  ReportItem.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/13/24.
//
import SwiftUI

enum ReportItem : Codable, Identifiable, Equatable {
    case keyMetric(KeyMetricTypes)
    case divider
    
    var id: String {
        switch self {
        case .divider:
            return "divider"
        case .keyMetric(let keyMetric):
            return keyMetric.id
        }
    }
    
    @ViewBuilder
    func content(scenario: TaxScenario, taxScheme: TaxScheme) -> some View {
        let federalTaxes = FederalTaxCalc(scenario, taxScheme: taxScheme)
        let stateTaxes = NCTaxCalc(scenario, taxScheme: taxScheme)
        switch self {
        case .keyMetric(let keyMetric):
            CardItem(keyMetric.label, value: keyMetric.resolve(fedTax: federalTaxes, stateTax: stateTaxes))
        case .divider:
            Divider()
                .padding(5)
        }
    }
}

extension ReportItem: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .json)
    }
}
