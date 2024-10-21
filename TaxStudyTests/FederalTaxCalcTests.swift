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
    
    @Test func testSimpleWageSelfEmployed() async throws {
        let scenario = TaxScenario(
            name: "$100k Wages at 65",
            filingStatus: .marriedFilingJointly, facts: "2024")
        
        scenario.profileSelf.age = 65
        scenario.profileSelf.employmentStatus = .selfEmployed
        scenario.profileSelf.wages = 50000
        scenario.profileSelf.socialSecurity = 0
        scenario.profileSpouse.age = 65
        scenario.profileSpouse.employmentStatus = .selfEmployed
        scenario.profileSpouse.wages = 50000
        scenario.profileSpouse.socialSecurity = 0
        
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
            facts: "2024"
        )
        scenario.profileSelf.age = 65
        scenario.profileSelf.employmentStatus = .employed
        scenario.profileSelf.wages = 50000
        scenario.profileSelf.socialSecurity = 0
        scenario.profileSpouse.age = 65
        scenario.profileSpouse.employmentStatus = .employed
        scenario.profileSpouse.wages = 50000
        scenario.profileSpouse.socialSecurity = 0
        
        
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
            facts: "2024"
        )
        
        scenario.profileSelf.age = 65
        scenario.profileSelf.employmentStatus = .retired
        scenario.profileSelf.socialSecurity = 3200*12
        scenario.profileSpouse.age = 65
        scenario.profileSpouse.employmentStatus = .retired
        scenario.profileSpouse.socialSecurity = 2000*12
        
        let fedTax = FederalTaxCalc(scenario, facts: DefaultTaxFacts2024)
        
        // MARK: Social Security Only
        
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
        #expect(fedTax.ordinaryIncome == 0)
        #expect(fedTax.ordinaryIncomeTax == 0)
        #expect(fedTax.preferentialIncome == 10_000)
        #expect(fedTax.qualifiedDividendTax == 0)
        #expect(fedTax.capitalGainsTax == 0)
        #expect(fedTax.netInvestmentIncomeTax == 0)
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
