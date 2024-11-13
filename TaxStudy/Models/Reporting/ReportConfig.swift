//
//  KeyMetricConfig.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/13/24.
//

class ReportConfig: Codable {
    var detailReport: [ReportSection]
    var compareReport: [ReportSection]
    
    init(detailReport: [ReportSection] = [], compareReport: [ReportSection] = []) {
        self.detailReport = detailReport
        self.compareReport = compareReport
    }
}
