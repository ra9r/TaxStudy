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
    var facts: [String: TaxFacts] = ["2024" : DefaultTaxFacts2024]
    
    private init() { /* Do Nothing */ }
    
    
    
}
