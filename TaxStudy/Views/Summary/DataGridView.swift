//
//  DataGridView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/13/24.
//

import SwiftUI

struct DataGridView : View {
    var federalTaxes: FederalTaxCalc
    
    init(_ scenario: TaxScenario, facts: TaxFacts? = nil) {
        self.federalTaxes = FederalTaxCalc(scenario, facts: facts)
    }
    
    var body: some View {
        MasonryVStack(columns: 2, spacing: 10) {
            incomeSources
            computedTaxes
            computedResults
            computedSocialSecurity
        }
    }
    
    var incomeSources: some View {
        DataCard("Income Sources", [
            ("Wages", federalTaxes.scenario.totalWages.asCurrency),
            ("Social Security", federalTaxes.scenario.totalSocialSecurityIncome.asCurrency),
            ("Net LTCG", federalTaxes.netLTCG.asCurrency),
            ("Net STCG", federalTaxes.netSTCG.asCurrency),
            ("Qualified Dividends", federalTaxes.scenario.qualifiedDividends.asCurrency),
            ("Non-Qualified Dividends", federalTaxes.scenario.ordinaryDividends.asCurrency),
            ("Interest", federalTaxes.scenario.interest.asCurrency),
            ("Rental Income", federalTaxes.scenario.rentalIncome.asCurrency),
            ("Royalties", federalTaxes.scenario.royalties.asCurrency),
            ("Business Income", federalTaxes.scenario.businessIncome.asCurrency),
            ("Foreign Earned Income", federalTaxes.scenario.foreignEarnedIncome.asCurrency),
            ("Tax-Emxempt Interest", federalTaxes.scenario.taxExemptInterest.asCurrency),
            ("Roth Conversions", federalTaxes.scenario.rothConversion.asCurrency),
            ("IRA Withdrawals", federalTaxes.scenario.iraWithdrawal.asCurrency),
            
        ])
    }
    
    var computedTaxes: some View {
        DataCard("Computed Taxes", [
            ("FICA Tax (Social Security)", federalTaxes.socialSecurityTaxesOwed.asCurrency),
            ("FICA Tax (Medicare)", federalTaxes.medicareTaxesOwed.asCurrency),
            ("Ordinary Income Tax", federalTaxes.ordinaryIncomeTax.asCurrency),
            ("Qualified Dividend Tax", federalTaxes.qualifiedDividendTax.asCurrency),
            ("Capital Gains Tax", federalTaxes.capitalGainsTax.asCurrency),
            ("Net Investment Income Tax (NIIT)", federalTaxes.netInvestmentIncomeTax.asCurrency),
        ])
    }
        
    var computedResults: some View {
        DataCard("Computed Results", [
            ("Total Income", federalTaxes.totalIncome.asCurrency),
            ("AGI", federalTaxes.agi.asCurrency),
            ("Net Investment Income (NII)", federalTaxes.netInvestmentIncome.asCurrency),
            ("Total Taxable Income", federalTaxes.taxableIncome.asCurrency),
            ("Total Preferential Income", federalTaxes.preferentialIncome.asCurrency),
            ("Total Ordinary Income", federalTaxes.ordinaryIncome.asCurrency),
            ("Future Carry Forward Loss", federalTaxes.futureCarryForwardLoss.asCurrency),
        ])
    }
    
    var computedSocialSecurity: some View {
        DataCard("Social Securty", [
            ("Gross Social Security Income", federalTaxes.scenario.totalSocialSecurityIncome.asCurrency),
            ("AGI (Before SS Income)", federalTaxes.agiBeforeSSDI.asCurrency),
            ("Provisional Income", federalTaxes.provisionalIncome.asCurrency),
            ("% of Social Security Taxed", federalTaxes.provisionalTaxRate.asPercentage),
            
            ("Taxable SS Income", federalTaxes.taxableSSDI.asCurrency)
        ])
    }
    
    
}
