//
//  Int+Extension.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/9/24.
//
import Foundation

extension Int {
    var noFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
