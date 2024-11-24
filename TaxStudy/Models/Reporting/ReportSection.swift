//
//  KeyMetricContainer.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/23/24.
//

import SwiftUI

class ReportSection: Codable, Identifiable {
    var id: String
    var title: String
    var items: [ReportItem]
    
    /// Returns a set of `KeyMetricTrypes` that are used in the list of `items`
    var keyMetrics: Set<KeyMetricTypes> {
        var keyMetricSet = Set<KeyMetricTypes>()

        for item in items {
            switch item {
            case .keyMetric(let keyMetric):
                keyMetricSet.insert(keyMetric)
            default:
                break
            }
        }
        
        return keyMetricSet
    }
    
    init(title: String, items: [ReportItem] = []) {
        self.id = UUID().uuidString
        self.title = title
        self.items = items
    }
}
