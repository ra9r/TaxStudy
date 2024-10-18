//
//  Deductions.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/14/24.
//
import SwiftUI

protocol DeductionType: Codable, Equatable, Hashable, CaseIterable, Identifiable {
    var label: String { get }
    var description: String { get }
    var isSupported: Bool { get }
}

struct Deduction<T: DeductionType>: Codable, Equatable, Identifiable {
    var id: UUID = UUID()
    var type: T
    var amount: Double
    var description: String?
    
    init(_ type: T, amount: Double, description: String? = nil) {
        self.type = type
        self.amount = amount
        self.description = description
    }
}

@Observable
class Deductions<T: DeductionType>: Codable {
    var items: [Deduction<T>]
    
    init(deductions: [Deduction<T>] = []) {
        self.items = deductions
    }
    
    func add(_ deduction: Deduction<T>) {
        items.append(deduction)
    }
    
    func remove(_ deduction: Deduction<T>) {
        // Remove the deduction that matches the type and amount
        items.removeAll { $0 == deduction }
    }
    
    func total(for deductionType: T) -> Double {
        items
            .filter { $0.type == deductionType }
            .reduce(0) { $0 + $1.amount }
    }
    
    // Custom Encodable conformance
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(items)
    }
    
    // Custom Decodable conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.items = try container.decode([Deduction<T>].self)
    }
}
