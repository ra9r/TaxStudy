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
    
    func asCurrency(_ maxFractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = maxFractionDigits
        formatter.minimumFractionDigits = 0
        formatter.locale = Locale.current // You can change this to another locale if needed
        
        return formatter.string(from: NSNumber(value: self))!
    }
    
    var asPercentage: String {
        let formatter = NumberFormatter()
                formatter.numberStyle = .percent
                formatter.maximumFractionDigits = 2
                formatter.minimumFractionDigits = 0
                return formatter.string(from: NSNumber(value: self)) ?? "\(self * 100)%"
    }
}

extension Double {
    func roundedCurrency(_ decimals: Int = 0) -> Double {
        let multiplier = pow(10.0, Double(decimals))
        return (self * multiplier).rounded() / multiplier
    }
}

extension Double {
    func roundedPercentage(_ decimals: Int = 0) -> Double {
        let percentage = self * 100
        let multiplier = pow(10.0, Double(decimals))
        return (percentage * multiplier).rounded() / multiplier
    }
}
