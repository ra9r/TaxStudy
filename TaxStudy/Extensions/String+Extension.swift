//
//  String+Extension.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import Foundation

extension String {
    var asDouble: Double {
        return Double(self) ?? 0.0
    }

    static func prettyPrint<T: Codable>(_ object: T) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // This makes the JSON output pretty-printed
        
        do {
            let jsonData = try encoder.encode(object)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            } else {
                return nil
            }
        } catch {
            print("Error encoding object: \(error)")
            return nil
        }
    }
}
