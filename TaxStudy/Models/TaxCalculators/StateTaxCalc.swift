//
//  StateTaxCalc.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

protocol StateTaxCalc {
    var federalTaxCalc: FederalTaxCalc { get set }
    
    var taxesOwed: Double { get }
    
    var effectiveTaxRate: Double { get }
}
