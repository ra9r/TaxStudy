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
    
    let manager: AppData
    
    init () async throws {
        // Access the test bundle
        let bundle = Bundle(for: FederalTaxCalcTests.self)
        
        // Locate the JSON file
        let fileURL = try #require(bundle.url(forResource: "2024EstimatedTax", withExtension: "json"))
        
        self.manager = AppData()
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
    
    @Test func testSimpleWageSelfEmployed() async throws {
        let scenario = TaxScenario(
            name: "$100k Wages at 65",
            filingStatus: .marriedFilingJointly,
            employmentStatus: .selfEmployed,
            ageSelf: 65,
            ageSpouse: 65
        )
        
        scenario.income.add(.init(.wagesSelf, amount: 50_000))
        scenario.income.add(.init(.wagesSpouse, amount: 50_000))
        
        let fedTax = FederalTaxCalc(scenario, facts: DefaultTaxFacts2024)
        
        #expect(fedTax.grossIncome == 100_000)
        #expect(fedTax.totalIncome == 100_000)
        #expect(fedTax.agi == 100_000)
        #expect(fedTax.deduction == 32_300)
        #expect(fedTax.taxableIncome.roundedCurrency() == 67_700)
        #expect(fedTax.taxesOwed.roundedCurrency() == 7_660)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.12)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 7.7)
        
        #expect(fedTax.netLTCG == 0)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxableSSI == 0)
        
        #expect(fedTax.scenario.wagesSelf == 50_000)
        #expect(fedTax.scenario.wagesSpouse == 50_000)
        
        #expect(fedTax.totalFICATaxSocialSecurity == 6200*2)
        #expect(fedTax.totalFICATaxMedicare == 2_900*2)
        
        #expect(fedTax.totalFICATax == 9100*2)
        
        // Now change the filing status to single and confirm that the spousal wages are ignored.
        scenario.filingStatus = .single
        #expect(fedTax.totalFICATaxSocialSecurity == 6200)
        #expect(fedTax.totalFICATaxMedicare == 2_900)
        #expect(fedTax.totalFICATax == 9100)
        
    }
    
    @Test func testSimpleWageNotSelfEmployed() async throws {
        let scenario = TaxScenario(
            name: "$100k Wages at 65",
            filingStatus: .marriedFilingJointly,
            employmentStatus: .employed,
            ageSelf: 65,
            ageSpouse: 65
        )
        
        scenario.income.add(.init(.wagesSelf, amount: 50_000))
        scenario.income.add(.init(.wagesSpouse, amount: 50_000))
        
        let fedTax = FederalTaxCalc(scenario, facts: DefaultTaxFacts2024)
        
        #expect(fedTax.grossIncome == 100_000)
        #expect(fedTax.totalIncome == 100_000)
        #expect(fedTax.agi == 100_000)
        #expect(fedTax.deduction == 32_300)
        #expect(fedTax.taxableIncome.roundedCurrency() == 67_700)
        #expect(fedTax.taxesOwed.roundedCurrency() == 7_660)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.12)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 7.7)
        
        #expect(fedTax.netLTCG == 0)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxableSSI == 0)
        
        #expect(fedTax.scenario.wagesSelf == 50_000)
        #expect(fedTax.scenario.wagesSpouse == 50_000)
        
        #expect(fedTax.totalFICATaxSocialSecurity == 3100*2)
        #expect(fedTax.totalFICATaxMedicare == 1450*2)
        #expect(fedTax.totalFICATax == 4550*2)
        
        // Now change the filing status to single and confirm that the spousal wages are ignored.
        scenario.filingStatus = .single
        #expect(fedTax.totalFICATaxSocialSecurity == 3100)
        #expect(fedTax.totalFICATaxMedicare == 1450)
        #expect(fedTax.totalFICATax == 4550)
        
    }
    
    @Test func testZeroTaxOn100k() async throws {
        let scenario = TaxScenario(
            name: "$0 Tax on $100,000",
            filingStatus: .marriedFilingJointly,
            employmentStatus: .retired,
            ageSelf: 65,
            ageSpouse: 65
        )
        let fedTax = FederalTaxCalc(scenario, facts: DefaultTaxFacts2024)
        
        // MARK: Social Security Only
        scenario.income.add(.init(.socialSecuritySelf, amount: 3200*12))
        scenario.income.add(.init(.socialSecuritySpouse, amount: 2000*12))
        
        #expect(fedTax.deduction == 32_300)
        #expect(fedTax.grossIncome == 62_400)
        #expect(fedTax.totalIncome == fedTax.grossIncome)
        #expect(fedTax.agi == 0)
        
        #expect(fedTax.netLTCG == 0)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxableIncome == 0)
        #expect(fedTax.taxesOwed == 0)
        #expect(fedTax.taxableSSI == 0)
        #expect(fedTax.provisionalIncome == 31_200)
        #expect(fedTax.provisionalTaxRate == 0.0)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.1)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 0)
        
        // MARK: Add Dividend Income
        scenario.income.add(.init(.qualifiedDividends, amount: 10_000))
        
        #expect(fedTax.grossIncome == 72_400)
        #expect(fedTax.totalIncome == fedTax.grossIncome)
        #expect(fedTax.agi == 14_600)
        #expect(fedTax.netLTCG == 0)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxableIncome == 0)
        #expect(fedTax.taxesOwed == 0)
        #expect(fedTax.taxableSSI == 4_600)
        #expect(fedTax.provisionalIncome == 41_200)
        #expect(fedTax.provisionalTaxRate == 0.5)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.1)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 0)
        
        // MARK: Add IRA Withdrawal
        scenario.income.add(.init(.iraWithdrawal, amount: 11_600))
        
        #expect(fedTax.grossIncome == 84_000)
        #expect(fedTax.totalIncome == fedTax.grossIncome)
        #expect(fedTax.agi == 35_080)
        #expect(fedTax.netLTCG == 0)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxableIncome == 2_780)
        #expect(fedTax.taxesOwed == 0)
        #expect(fedTax.taxableSSI == 13_480)
        #expect(fedTax.provisionalIncome == 52_800)
        #expect(fedTax.provisionalTaxRate == 0.85)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.10)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 0)
        
        // MARK: Add LTCG $16,000 of which 50% is gains
        scenario.income.add(.init(.longTermCapitalGains, amount: 8_000))
        scenario.income.add(.init(.otherTaxExemptIncome, amount: 8_000)) // return of capital (cost basis)
        
        #expect(fedTax.grossIncome == 100_000)
        #expect(fedTax.totalIncome == 92_000)
        #expect(fedTax.agi == 49_880)
        #expect(fedTax.netLTCG == 8000)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxableIncome == 17_580)
        #expect(fedTax.taxesOwed == 0)
        #expect(fedTax.taxableSSI == 20_280)
        #expect(fedTax.provisionalIncome == 60_800)
        #expect(fedTax.provisionalTaxRate == 0.85)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.10)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 0)
        
        
        
        #expect(fedTax.deduction == 32_300)
        #expect(fedTax.grossIncome == 100_000)
        #expect(fedTax.totalIncome == 92_000)
        #expect(fedTax.netLTCG == 8_000)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxesOwed == 0)
        #expect(fedTax.taxableSSI == 20_280)
        #expect(fedTax.provisionalIncome == 60_800)
        #expect(fedTax.provisionalTaxRate == 0.85)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.10)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 0)
        
    }
    
}
