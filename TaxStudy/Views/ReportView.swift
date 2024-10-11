//
//  ReportView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/9/24.
//
import SwiftUI

struct ReportView : View {
    var ts: TaxScenario
//    @State var item: Int = 1
    
    var body: some View {
        ScrollView {
//            Picker("Tax Scenario", selection: $item) {
//                Text("One").tag(1)
//                Text("Two").tag(2)
//                Text("Three").tag(3)
//            }
//            .pickerStyle(.segmented)
//            .labelsHidden()
//            .tint(.primary)
//            .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                header("Gross Income")
                body("The gross income is the sum of all the income you receive from your job, investments, and other sources.")
                callout(Text("ℹ️ **Gross Income** = \(ts.grossIncome.asCurrency)"))
                
                header("Combined SSI")
                body("The combined Social Security Income is the sum of the Social Security Income of the spouse and the self.")
                callout(Text("ℹ️ **Combined Social Security Income** = Spouse SSI \(ts.socialSecuritySpouse.asCurrency) + Self SSI \(ts.socialSecuritySelf.asCurrency) = \(ts.totalSocialSecurityIncome.asCurrency)"))
                
                
                header("Net Capital Gains")
                body("The net capital gain or loss is essentially the total profit or loss from the sale of a stock or ETF.  Because we will not often be selling assets, and because of the large carryover capital loss, we will likely always have a capital loss more many years to come.")
                callout(Text("ℹ️ **Net Capital Goan/Loss** = Capital Gains (\(ts.longTermCapitalGains.asCurrency)) - Capital Losses (\(ts.longTermCapitalLosses.asCurrency)) - Capital Loss Carryover (\(ts.capitalLossCarryOver.asCurrency)) = \(ts.federalTaxes.netLTCG.asCurrency)"))
                
                header("Total Dividends")
                body("The total combination of qualified and unqualified dividends received by the taxpayer.")
                callout(Text("ℹ️ **Total Dividends** = Non-Qualified Dividends \(ts.nonQualifiedDividends.asCurrency) + Qualified Dividends \(ts.qualifiedDividends.asCurrency) = \(ts.federalTaxes.totalDividends.asCurrency)"))
                
                header("AGI before SSDI")
                body("Your adjusted gross income (AGI) before SSDI is all your income (excluding Tax-Exempt muni bond interest and your income from SSDI). If you contribute to your HSA, it is taken out here.")
                callout(Text("ℹ️ **AGI before SSDI** = Gross Income (\(ts.grossIncome.asCurrency)) - Social Security Income (\(ts.totalSocialSecurityIncome.asCurrency)) - Tax Exempt Interest (\(ts.taxExemptInterest.asCurrency)) - Capital Losses Ajustment (\(ts.federalTaxes.capitalLossDeduction.asCurrency)) - HSA Contribution (\(ts.hsaContribution.asCurrency)) = \(ts.federalTaxes.agiBeforeSSDI.asCurrency)"))
            }
            .padding()
        }
    }
    
    func header(_ text: String) -> some View {
        Text(text).font(.largeTitle)
            .padding(.top, 10)
            .padding(.bottom, 10)
    }
    
    func body(_ text: String) -> some View {
        Text(text).font(.system(size: 18, weight: .light))
            
    }
    
    func body(_ text: Text) -> some View {
        text.font(.system(size: 18, weight: .light))
    }
    
    func callout(_ text: Text) -> some View {
        GroupBox {
            text
                .font(.system(size: 14))
                .padding()
        }
    }
}

#Preview {
    @Previewable @State var manager = TaxScenarioManager()
    ReportView(ts: manager.selectedTaxScenario)
        .onAppear() {
            do {
                try manager.open(from: URL(fileURLWithPath: "/Users/rodney/Desktop/2024EstimatedTax.json"))
            } catch {
                print(error)
            }
        }
}
