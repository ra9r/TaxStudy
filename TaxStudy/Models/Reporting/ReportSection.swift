//
//  KeyMetricContainer.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/23/24.
//

import SwiftUI

struct ReportSection: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var items: [any ReportItem & Identifiable]
    
    var keyMetrics: Set<KeyMetricTypes> {
        var keyMetricSet = Set<KeyMetricTypes>()

        for item in items {
            if let keyMetricItem = item as? KeyMetricReportItem {
                keyMetricSet.insert(keyMetricItem.keyMetric)
            }
        }
        
        return keyMetricSet
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case items
        case type
    }

    init(id: String? = nil, title: String, items: [any ReportItem]) {
        self.id = id ?? UUID().uuidString
        self.title = title
        self.items = items
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        
        var itemsContainer = container.nestedUnkeyedContainer(forKey: .items)
        
        for item in items {
            switch item {
            case let keyMetricItem as KeyMetricReportItem:
                try itemsContainer.encode(keyMetricItem)
                
            case let dividerItem as DividerReportItem:
                try itemsContainer.encode(dividerItem)
                
            default:
                throw EncodingError.invalidValue(item, EncodingError.Context(codingPath: itemsContainer.codingPath, debugDescription: "Unknown ReportItem type"))
            }
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        
        var itemsContainer = try container.nestedUnkeyedContainer(forKey: .items)
        var decodedItems: [any ReportItem] = []

        while !itemsContainer.isAtEnd {
            let typeContainer = try itemsContainer.nestedContainer(keyedBy: CodingKeys.self)
            let type = try typeContainer.decode(String.self, forKey: .type)
            
            switch type {
            case "KeyMetricReportItem":
                let keyMetricItem = try itemsContainer.decode(KeyMetricReportItem.self)
                decodedItems.append(keyMetricItem)
                
            case "DividerReportItem":
                let dividerItem = try itemsContainer.decode(DividerReportItem.self)
                decodedItems.append(dividerItem)
                
            default:
                throw DecodingError.dataCorruptedError(forKey: .items, in: typeContainer, debugDescription: "Unknown ReportItem type")
            }
        }
        
        items = decodedItems
    }
}
