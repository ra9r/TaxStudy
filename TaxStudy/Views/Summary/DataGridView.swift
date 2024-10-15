//
//  DataGridView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/13/24.
//

import SwiftUI

struct DataGridView : View {
    var ts: TaxScenario
    
    init(_ ts: TaxScenario) {
        self.ts = ts
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
            ("Wages", ts.totalWages.asCurrency),
            ("Social Security", ts.totalSocialSecurityIncome.asCurrency),
            ("Net LTCG", ts.federalTaxes.netLTCG.asCurrency),
            ("Net STCG", ts.federalTaxes.netSTCG.asCurrency),
            ("Qualified Dividends", ts.qualifiedDividends.asCurrency),
            ("Non-Qualified Dividends", ts.nonQualifiedDividends.asCurrency),
            ("Interest", ts.interest.asCurrency),
            ("Rental Income", ts.rentalIncome.asCurrency),
            ("Royalties", ts.royalties.asCurrency),
            ("Business Income", ts.businessIncome.asCurrency),
            ("Foreign Earned Income", ts.foreignEarnedIncome.asCurrency),
            ("Tax-Emxempt Interest", ts.taxExemptInterest.asCurrency),
            ("Roth Conversions", ts.rothConversion.asCurrency),
            ("IRA Withdrawals", ts.iraWithdrawal.asCurrency),
            
        ])
    }
    
    var computedTaxes: some View {
        DataCard("Computed Taxes", [
            ("FICA Tax (Social Security)", ts.federalTaxes.socialSecurityTaxesOwed.asCurrency),
            ("FICA Tax (Medicare)", ts.federalTaxes.medicareTaxesOwed.asCurrency),
            ("Ordinary Income Tax", ts.federalTaxes.ordinaryIncomeTax.asCurrency),
            ("Qualified Dividend Tax", ts.federalTaxes.qualifiedDividendTax.asCurrency),
            ("Capital Gains Tax", ts.federalTaxes.capitalGainsTax.asCurrency),
            ("Net Investment Income Tax (NIIT)", ts.federalTaxes.netInvestmentIncomeTax.asCurrency),
        ])
    }
        
    var computedResults: some View {
        DataCard("Computed Results", [
            ("Gross Income", ts.grossIncome.asCurrency),
            ("AGI", ts.federalTaxes.agi.asCurrency),
            ("Net Investment Income (NII)", ts.federalTaxes.netInvestmentIncome.asCurrency),
            ("Total Taxable Income", ts.federalTaxes.taxableIncome.asCurrency),
            ("Total Preferential Income", ts.federalTaxes.preferentialIncome.asCurrency),
            ("Total Ordinary Income", ts.federalTaxes.ordinaryIncome.asCurrency),
            ("Future Carry Over Loss", ts.federalTaxes.futureCarryOverLoss.asCurrency),
        ])
    }
    
    var computedSocialSecurity: some View {
        DataCard("Social Securty", [
            ("Gross Social Security Income", ts.totalSocialSecurityIncome.asCurrency),
            ("AGI (Before SS Income)", ts.federalTaxes.agiBeforeSSDI.asCurrency),
            ("Provisional Income", ts.federalTaxes.provisionalIncome.asCurrency),
            ("% of Social Security Taxed", ts.federalTaxes.provisionalTaxRate.asPercentage),
            
            ("Taxable SS Income", ts.federalTaxes.taxableSSDI.asCurrency)
        ])
    }
    
    
}
