//
//  ReportView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/9/24.
//
import SwiftUI

struct SummaryView : View {
    var ts: TaxScenario
    //    @State var item: Int = 1
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                header
                metaHeader
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                HStack(alignment: .top) {
                    incomeSources
                    computedResults
                }
                
            }
            .padding()
            
            
        }
        .frame(minWidth: 800)
    }
    
    /// <#Description#>
    var metaHeader: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                MetaCard(
                    symbolName: ts.filingStatus.symbol,
                    label: "Filing Status",
                    value: "\(ts.filingStatus.rawValue)"
                )
                MetaCard(
                    symbolName: "briefcase",
                    label: "Employment Status",
                    value: "\(ts.employmentStatus.rawValue)"
                )
                MetaCard(
                    symbolName: "scissors",
                    label: "Deduction Method",
                    value: "\(ts.federalTaxes.deductionMethod)"
                )
                MetaCard(
                    symbolName: "building.columns",
                    label: "Federal Taxes",
                    value: "\(ts.federalTaxes.taxesOwed.asCurrency) (\(ts.federalTaxes.effectiveTaxRate.asPercentage))"
                )
                MetaCard(
                    symbolName: "map",
                    label: "State Taxes",
                    value: "\(ts.stateTaxes.taxesOwed.asCurrency) (\(ts.stateTaxes.effectiveTaxRate.asPercentage))"
                )
                MetaCard(
                    symbolName: "percent",
                    label: "Effective Tax Rate",
                    value: "\(ts.totalEffectiveTaxRate.asPercentage)"
                )
                Spacer()
            }
            .padding(.bottom, 5)
        }
    }
    
    var header: some View {
        HStack(alignment: .top, spacing: 25) {
            blueBox
            nameAndDescription
            Spacer()
        }
    }
    
    var blueBox: some View {
        HStack {
            Text("2024")
                .font(.largeTitle)
            Divider()
            VStack(alignment: .trailing) {
                Text("\(ts.grossIncome.asCurrency)")
                    .font(.headline)
                Text("Gross Income")
                    .font(.subheadline)
            }
        }
        .frame(minWidth: 200)
        .padding()
        .foregroundStyle(.white)
        .background(.accent)
        .cornerRadius(5)
    }
    
    var nameAndDescription: some View {
        VStack(alignment: .leading) {
            Text("\(ts.name)")
                .font(.title)
            Text("\(ts.description)")
                .font(.subheadline)
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
            ("Roth Conversions", ts.rothConversion.asCurrency),
            ("IRA Withdrawals", ts.iraWithdrawal.asCurrency)
            
        ])
    }
    
    var computedResults: some View {
        VStack {
            DataCard("Computed Taxes", [
                ("FICA Tax (Social Security)", ts.federalTaxes.socialSecurityTaxesOwed.asCurrency),
                ("FICA Tax (Medicare)", ts.federalTaxes.medicareTaxesOwed.asCurrency),
                ("Ordinary Income Tax", ts.federalTaxes.ordinaryIncomeTax.asCurrency),
                ("Qualified Dividend Tax", ts.federalTaxes.qualifiedDividendTax.asCurrency),
                ("Capital Gains Tax", ts.federalTaxes.capitalGainsTax.asCurrency),
                ("Net Investment Income Tax (NIIT)", ts.federalTaxes.netInvestmentIncomeTax.asCurrency),
            ])
            DataCard("Computed Results", [
                ("Gross Income", ts.grossIncome.asCurrency),
                ("AGI", ts.federalTaxes.agi.asCurrency),
                ("Net Investment Income (NII)", ts.federalTaxes.netInvestmentIncome.asCurrency),
                ("Total Ordinary Income", ts.federalTaxes.ordinaryIncome.asCurrency),
                ("Total Taxable Income", ts.federalTaxes.taxableIncome.asCurrency),
            ])
            DataCard("Social Securty", [
                ("Gross Social Security Income", ts.totalSocialSecurityIncome.asCurrency),
                ("AGI (Before SS Income)", ts.federalTaxes.agiBeforeSSDI.asCurrency),
                ("Provisional Income", ts.federalTaxes.provisionalIncome.asCurrency),
                ("% of Social Security Taxed", ts.federalTaxes.provisionalTaxRate.asPercentage),
                
                ("Taxable SS Income", ts.federalTaxes.taxableSSDI.asCurrency)
            ])
        }
    }
    
    
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var manager = TaxScenarioManager()
    SummaryView(ts: manager.selectedTaxScenario)
        .frame(minHeight: 800)
        .onAppear() {
            do {
                try manager.open(from: URL(fileURLWithPath: "/Users/rodney/Desktop/2024EstimatedTax.json"))
            } catch {
                print(error)
            }
        }
}
