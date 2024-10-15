//
//  Deductions.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/14/24.
//
import SwiftUI

protocol DeductionType: Codable, Equatable {
    var label: String { get }
    var description: String { get }
}

struct GenericDeduction<T: DeductionType>: Codable, Equatable {
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
    var items: [GenericDeduction<T>]
    
    init(deductions: [GenericDeduction<T>] = []) {
        self.items = deductions
    }
    
    func add(_ deduction: GenericDeduction<T>) {
        items.append(deduction)
    }
    
    func remove(_ deduction: GenericDeduction<T>) {
        items.removeAll(where: { $0 == deduction })
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
        self.items = try container.decode([GenericDeduction<T>].self)
    }
}
