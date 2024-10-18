//
//  TaxStudyTests.swift
//  TaxStudyTests
//
//  Created by Rodney Aiglstorfer on 10/18/24.
//

import Testing
import Foundation

@testable import TaxStudy

final class FederalTaxCalcTests {
    
    let manager: TaxScenarioManager
    
    init () async throws {
        // Access the test bundle
        let bundle = Bundle(for: FederalTaxCalcTests.self)
                
        // Locate the JSON file
        let fileURL = try #require(bundle.url(forResource: "2024EstimatedTax", withExtension: "json"))
        
        self.manager = TaxScenarioManager()
        try self.manager.open(from: fileURL)
    }

    @Test func computeNII() async throws {

        let scenario = try #require(manager.taxScenarios.first)
        
        let ftc = FederalTaxCalc(scenario)
        
        #expect(ftc.netLTCG == 0)
        #expect(ftc.netSTCG == 0)
        #expect(ftc.scenario.totalDividends > 0)
        #expect(ftc.scenario.interest > 0)
        #expect(ftc.scenario.rentalIncome == 0)
        #expect(ftc.scenario.royalties == 0)
        #expect(ftc.scenario.deductions.total(for: .marginInterestDeduction) > 0)
        #expect(ftc.scenario.deductions.total(for: .rentalPropertyExpensesDeduction) == 0)
        
        #expect(ftc.netInvestmentIncome > 0)
        
        
    }

}
