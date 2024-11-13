//
//  KeyMetricContainer.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/23/24.
//

import SwiftUI

struct ReportSection: Codable {
    var title: String
    var keyMetrics: [KeyMetricTypes]

    init(title: String, keyMetrics: [KeyMetricTypes]) {
        self.title = title
        self.keyMetrics = keyMetrics
    }
}
