//
//  ScenarioEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/28/24.
//

import SwiftUI

struct IncomeEditor: View {
    @Binding var ts: TaxScenario
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Header(ts: $ts)
                MetaHeaderView(ts)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                HStack(alignment: .top) {
                    VStack(spacing: 10) {
                        CardView("Wages") {
                            CardField("Self", amount: $ts.wagesSelf)
                            Divider()
                            CardField("Spouse", amount: $ts.wagesSpouse)
                        }
                        CardView("Social Security") {
                            CardField("Self", amount: $ts.socialSecuritySelf)
                            Divider()
                            CardField("Spouse", amount: $ts.socialSecuritySpouse)
                        }
                        CardView("Retirement") {
                            CardField("Roth Conversion", amount: $ts.rothConversion)
                            Divider()
                            CardField("IRA Withdrawal", amount: $ts.iraWithdrawal)
                        }
                        CardView("Other Income") {
                            CardField("Rental Income", amount: $ts.rentalIncome)
                            Divider()
                            CardField("Royalties", amount: $ts.royalties)
                            Divider()
                            CardField("Business Income", amount: $ts.businessIncome)
                            Divider()
                            CardField("Foreign Earned Income (FEIE)", amount: $ts.foreignEarnedIncome)
                        }
                    }
                    VStack(spacing: 10) {
                        CardView("Capital Gains") {
                            CardField("Long-term", amount: $ts.longTermCapitalGains)
                            Divider()
                            CardField("Short-term", amount: $ts.shortTermCapitalGains)
                        }
                        CardView("Capital Losses") {
                            CardField("Long-term", amount: $ts.longTermCapitalLosses)
                            Divider()
                            CardField("Short-term", amount: $ts.shortTermCapitalLosses)
                            Divider()
                            CardField("Carried Forward", amount: $ts.capitalLossCarryOver)
                        }
                        CardView("Dividends") {
                            CardField("Qualified", amount: $ts.qualifiedDividends)
                            Divider()
                            CardField("Non-Qualified (Ordinary)", amount: $ts.nonQualifiedDividends)
                        }
                        CardView("Interest") {
                            CardField("Tax-Exempt Interest", amount: $ts.taxExemptInterest)
                            Divider()
                            CardField("Interest", amount: $ts.interest)
                        }
                        
                    }
                }
                .padding()
            }
            .padding()
            
            
        }
        .frame(minWidth: 800)
        
    }
    
}

#Preview {
    ContentView()
}
