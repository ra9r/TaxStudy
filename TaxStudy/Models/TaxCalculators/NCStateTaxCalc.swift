//
//  NCStateTaxCalc.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/1/24.
//

class NCTaxCalc : StateTaxCalc {
    var federalTaxCalc: FederalTaxCalc
    
    init(_ federalTaxCalc: FederalTaxCalc) {
        self.federalTaxCalc = federalTaxCalc
    }
    
    var taxesOwed: Double {
        // NC State Tax rate for 2023 is 4.75%
        let ncDeduction = 13000.0
        let taxableIncome = federalTaxCalc.agi - ncDeduction + federalTaxCalc.taxScenario.taxExemptInterest - federalTaxCalc.taxScenario.totalSocialSecurityIncome
        let tax = taxableIncome * 0.046
        return max(0, tax)
    }
    
    var effectiveTaxRate: Double {
        if federalTaxCalc.taxScenario.grossIncome == 0 {
            return 0
        }
        return taxesOwed / federalTaxCalc.taxScenario.grossIncome
    }
}
