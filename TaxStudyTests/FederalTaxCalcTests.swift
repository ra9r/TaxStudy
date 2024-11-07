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
    
    // Define the path relative to the test file
    var samplePath: URL {
        let currentDirectory = URL(fileURLWithPath: #file).deletingLastPathComponent()
        return currentDirectory.appendingPathComponent("Samples")
    }
    
    func loadTaxScenario(filename: String) throws -> TaxScenario? {
        let fileURL = samplePath.appendingPathComponent(filename)
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
//            throw AppErrors.fileNotFound(fileURL.path)
            print("Error: File not found: \(fileURL.path)")
            #expect(Bool(false))
            return nil
        }
        
        // Load the data from the file
        let data = try Data(contentsOf: fileURL)
        
        // Decode the data into your model
        let decoder = JSONDecoder()
        return try decoder.decode(TaxScenario.self, from: data)
    }
    
    @Test func testAMForCoreFolio() async throws {
        guard let scenario = try loadTaxScenario(filename: "CurrentCoreFolioWRodney.txscn") else {
            print("Error: Sample TaxScenario  Not Loaded")
            #expect(Bool(false))
            return
        }
        let fedTax = FederalTaxCalc(scenario, facts: TaxFacts.official2024)
        
        #expect(fedTax.grossIncome == 194_714.28)
        #expect(fedTax.totalIncome == 194_714.28)
        #expect(fedTax.amtIncome.asCurrency ==  "$186,414.28")
        #expect(fedTax.amtExemption == 126_500)
        #expect(fedTax.amtPhaseOutTheshold == 1_156_300)
        #expect(fedTax.amtReducedExemption == 126_500)
        #expect(fedTax.amtTaxableIncome.asCurrency == "$59,914.28")
        let taxParts = fedTax.amtTaxParts
        #expect(taxParts.isEmpty == false)
        #expect(taxParts.count == 1)
        // 0% Bracket
        #expect(taxParts[0].rate == 0.26)
        #expect(taxParts[0].threshold == 0)
        #expect(taxParts[0].taxableAtRate.asCurrency == "$59,914.28")
        #expect(taxParts[0].computedTax.asCurrency == "$15,577.71")
        // 26% Bracket
        #expect(fedTax.amtTax.asCurrency == "$15,577.71")
        #expect(fedTax.federalTax.asCurrency(0) == "$7,945")
        #expect(fedTax.isSubjectToAMT == true)
    }
    
    @Test func testAMT700k() async throws {
        let scenario = TaxScenario(
            name: "$100k Wages at 65",
            filingStatus: .single, facts: "2024")
        
        scenario.profileSelf.age = 50
        scenario.profileSelf.employmentStatus = .selfEmployed
        scenario.profileSelf.wages = 700_000
        scenario.profileSelf.socialSecurity = 0

        
        let fedTax = FederalTaxCalc(scenario, facts: TaxFacts.official2024)
        
        #expect(fedTax.amtIncome == 700_000)
        #expect(fedTax.amtExemption == 81_300)
        #expect(fedTax.amtPhaseOutTheshold == 578_150)
        #expect(fedTax.amtReducedExemption.asCurrency == "$50,837.50")
        #expect(fedTax.amtTaxableIncome.asCurrency == "$649,162.50")
        let taxParts = fedTax.amtTaxParts
        #expect(taxParts.isEmpty == false)
        #expect(taxParts.count == 2)
        // 0% Bracket
        #expect(taxParts[0].rate == 0.26)
        #expect(taxParts[0].threshold == 0)
        #expect(taxParts[0].taxableAtRate.asCurrency(0) == "$220,700")
        #expect(taxParts[0].computedTax.asCurrency == "$57,382.00")
        // 26% Bracket
        #expect(taxParts[1].rate == 0.28)
        #expect(taxParts[1].threshold == 220_700)
        #expect(taxParts[1].taxableAtRate.asCurrency == "$428,462.50")
        #expect(taxParts[1].computedTax.asCurrency == "$119,969.50")
        #expect(fedTax.amtTax.asCurrency == "$177,351.50")
        #expect(fedTax.federalTax == 212055.70)
        #expect(fedTax.isSubjectToAMT == false)
    }
    
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
        
        let fedTax = FederalTaxCalc(scenario, facts: TaxFacts.official2024)
        
        #expect(fedTax.grossIncome == 100_000)
        #expect(fedTax.totalIncome == 100_000)
        #expect(fedTax.agi == 100_000)
        #expect(fedTax.deduction == 32_300)
        #expect(fedTax.taxableIncome.roundedCurrency() == 67_700)
        #expect(fedTax.federalTax.roundedCurrency() == 7_660)
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
        
        
        let fedTax = FederalTaxCalc(scenario, facts: TaxFacts.official2024)
        
        #expect(fedTax.grossIncome == 100_000)
        #expect(fedTax.totalIncome == 100_000)
        #expect(fedTax.agi == 100_000)
        #expect(fedTax.deduction == 32_300)
        #expect(fedTax.taxableIncome.roundedCurrency() == 67_700)
        #expect(fedTax.federalTax.roundedCurrency() == 7_660)
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
        
        let fedTax = FederalTaxCalc(scenario, facts: TaxFacts.official2024)
        
        // MARK: Social Security Only
        
        #expect(fedTax.deduction == 32_300)
        #expect(fedTax.grossIncome == 62_400)
        #expect(fedTax.totalIncome == fedTax.grossIncome)
        #expect(fedTax.agi == 0)
        
        #expect(fedTax.netLTCG == 0)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxableIncome == 0)
        #expect(fedTax.federalTax == 0)
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
        #expect(fedTax.federalTax == 0)
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
        #expect(fedTax.federalTax == 0)
        #expect(fedTax.taxableSSI == 13_480)
        #expect(fedTax.provisionalIncome == 52_800)
        #expect(fedTax.provisionalTaxRate == 0.85)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.10)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 0)
        
        // MARK: Add LTCG $16,000 of which 50% is gains
        scenario.income.add(.init(.longTermCapitalGains, amount: 8_000))
        scenario.income.add(.init(.otherTaxExemptIncome, amount: 8_000)) // return of capital (cost basis)
        
//        return totalIncome +
//        scenario.longTermCapitalGains +
//        scenario.shortTermCapitalGains +
//        totalTaxExemptIncome
        #expect(fedTax.totalIncome == 92_000)
        #expect(fedTax.scenario.longTermCapitalGains == 8_000)
        #expect(fedTax.scenario.shortTermCapitalGains == 0)
        #expect(fedTax.scenario.otherTaxExemptIncome == 8_000)
        #expect(fedTax.grossIncome == 100_000)
        #expect(fedTax.agi == 49_880)
        #expect(fedTax.netLTCG == 8000)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxableIncome == 17_580)
        #expect(fedTax.federalTax == 0)
        #expect(fedTax.taxableSSI == 20_280)
        #expect(fedTax.provisionalIncome == 60_800)
        #expect(fedTax.provisionalTaxRate == 0.85)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.10)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 0)
        
        
        
        #expect(fedTax.deduction == 32_300)
        #expect(fedTax.totalIncome == 92_000)
        #expect(fedTax.netLTCG == 8_000)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.federalTax == 0)
        #expect(fedTax.taxableSSI == 20_280)
        #expect(fedTax.provisionalIncome == 60_800)
        #expect(fedTax.provisionalTaxRate == 0.85)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.10)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 0)
        
    }
    
    @Test func testZeroTaxOn120k() async throws {
        let scenario = TaxScenario(
            name: "$0 Tax on $120,000",
            filingStatus: .marriedFilingJointly,
            facts: "2024"
        )
        
        scenario.profileSelf.age = 65
        scenario.profileSelf.employmentStatus = .retired
        scenario.profileSelf.socialSecurity = 0
        scenario.profileSpouse.age = 65
        scenario.profileSpouse.employmentStatus = .retired
        scenario.profileSpouse.socialSecurity = 0
        
        let fedTax = FederalTaxCalc(scenario, facts: TaxFacts.official2024)
        // MARK: Tax Exempt Income
        scenario.income.add(.init(.taxExemptInterest, amount: 22_500))
        #expect(fedTax.grossIncome == 22_500)
        #expect(fedTax.totalIncome == 0)
        #expect(fedTax.agi == 0)
        #expect(fedTax.netLTCG == 0)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxableIncome == 0)
        #expect(fedTax.ordinaryIncome == 0)
        #expect(fedTax.ordinaryIncomeTax == 0)
        #expect(fedTax.preferentialIncome == 0)
        #expect(fedTax.qualifiedDividendTax == 0)
        #expect(fedTax.capitalGainsTax == 0)
        #expect(fedTax.netInvestmentIncomeTax == 0)
        #expect(fedTax.federalTax == 0)
        #expect(fedTax.taxableSSI == 0)
        #expect(fedTax.provisionalIncome == 22_500)
        
        // MARK: Add LTCG
        scenario.income.add(.init(.qualifiedDividends, amount: 10_000))
        
        #expect(fedTax.grossIncome == 32_500)
        #expect(fedTax.totalIncome == 10_000)
        #expect(fedTax.agi == 10_000)
        #expect(fedTax.netLTCG == 0)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxableIncome == 0)
        #expect(fedTax.ordinaryIncome == 0)
        #expect(fedTax.ordinaryIncomeTax == 0)
        #expect(fedTax.preferentialIncome == 10_000)
        #expect(fedTax.qualifiedDividendTax == 0)
        #expect(fedTax.capitalGainsTax == 0)
        #expect(fedTax.netInvestmentIncomeTax == 0)
        #expect(fedTax.federalTax == 0)
        #expect(fedTax.taxableSSI == 0)
        #expect(fedTax.provisionalIncome == 32_500)
        #expect(fedTax.provisionalTaxRate == 0.5)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.1)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 0)
        
        // MARK: Add IRA Withdrawal
        scenario.income.add(.init(.iraWithdrawal, amount: 30_000))
        
        #expect(fedTax.grossIncome == 62_500)
        #expect(fedTax.totalIncome == 40_000)
        #expect(fedTax.agi == 40_000)
        #expect(fedTax.netLTCG == 0)
        #expect(fedTax.netSTCG == 0)
        #expect(fedTax.taxableIncome == 7_700)
        #expect(fedTax.federalTax == 0)
        #expect(fedTax.taxableSSI == 0)
        #expect(fedTax.provisionalIncome == 62_500)
        #expect(fedTax.provisionalTaxRate == 0.85)
        #expect(fedTax.marginalOrdinaryTaxRate == 0.10)
        #expect(fedTax.averageTaxRate.roundedPercentage(1) == 0)
        
    }
    
}
