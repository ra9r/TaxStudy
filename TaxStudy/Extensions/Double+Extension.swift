//
//  Double+Extension.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/10/24.
//

import Foundation

extension Double {
    var asCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current // You can change this to another locale if needed
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
