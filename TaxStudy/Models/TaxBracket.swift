//
//  TaxBracket.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

struct TaxBracket : Codable {
    var rate: Double
    var threshold: Double
    
    init(_ threshold: Double, _ rate: Double) {
        self.rate = rate
        self.threshold = threshold
    }
}
