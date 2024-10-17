//
//  IncomeSources.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/16/24.
//
import SwiftUI

struct Income: Codable, Equatable, Identifiable, Hashable {
    var id: UUID = UUID()
    var type: IncomeType
    var amount: Double
    var note: String?
    
    init(_ type: IncomeType, amount: Double, note: String? = nil) {
        self.type = type
        self.amount = amount
        self.note = note
    }
}

@Observable
class IncomeSources: Codable {
    var sources: [Income]
    
    init(sources: [Income] = []) {
        self.sources = sources
    }
    
    func add(_ source: Income) {
        sources.append(source)
    }
    
    func remove(_ source: Income) {
        sources.removeAll(where: { $0.id == source.id })
    }
    
    func total(for incomeSourceType: IncomeType) -> Double {
        sources
            .filter { $0.type == incomeSourceType }
            .reduce(0) { $0 + $1.amount }
    }
    
    func matching(anyOf incomeTypes: [IncomeType]) -> [Income] {
        return sources.filter { incomeTypes.contains($0.type)}
    }
    
    // Custom Encodable conformance
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(sources)
    }
    
    // Custom Decodable conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.sources = try container.decode([Income].self)
    }
}
