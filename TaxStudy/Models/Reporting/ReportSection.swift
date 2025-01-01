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
    
    init(title: String, items: [ReportItem] = []) {
        self.id = UUID().uuidString
        self.title = title
        self.items = items
    }
    
    var keyMetrics: [KeyMetricTypes] {
        items.compactMap { reportItem in
            if case let .keyMetric(keyMetric) = reportItem.type {
                return keyMetric
            }
            return nil
        }
    }
}

extension ReportSection: Equatable {
    static func == (lhs: ReportSection, rhs: ReportSection) -> Bool {
        return lhs.id == rhs.id
    }
}
