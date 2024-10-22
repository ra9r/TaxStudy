//
//  AppServices.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//

import SwiftUI

@Observable
class AppServices {
    static let shared = AppServices()
    
//    var data: AppData = AppData()
//    var currentFile: URL?
    var facts: [TaxFacts] = [DefaultTaxFacts2024]
    
    func facts(for id: String) -> TaxFacts? {
        guard let fact = facts.first(where: { $0.id == id }) else {
            print("Error: No Fact Found for \(id)")
            return nil
        }
        return fact
    }
    
    private init() { /* Do Nothing */ }
    
    
    
}
