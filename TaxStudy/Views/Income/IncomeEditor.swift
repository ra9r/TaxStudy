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
                MasonryVStack(columns: 3, spacing: 10) {
                    CardView {
                        HStack {
                            Text("Wages")
                            Spacer()
                        }
                    } content: {
                        Group {
                            CurrencyField(title: "Self", amount: $ts.wagesSelf)
                                
                            Divider()
                            CurrencyField(title: "Spouse", amount: $ts.wagesSpouse)
                        }
                        .padding(2.5)
                    }
                    CardView {
                        HStack {
                            Text("Social Security")
                            Spacer()
                        }
                    } content: {
                        CurrencyField(title: "Self", amount: $ts.socialSecuritySelf)
                        Divider()
                        CurrencyField(title: "Spouse", amount: $ts.socialSecuritySpouse)
                    }
                    CardView {
                        HStack {
                            Text("Capital Gains")
                            Spacer()
                        }
                    } content: {
                        CurrencyField(title: "Long-term", amount: $ts.longTermCapitalGains)
                        Divider()
                        CurrencyField(title: "Short-term", amount: $ts.shortTermCapitalGains)
                    }
                    CardView {
                        HStack {
                            Text("Capital Losses")
                            Spacer()
                        }
                    } content: {
                        CurrencyField(title: "Long-term", amount: $ts.longTermCapitalLosses).padding(0)
                        Divider()
                        CurrencyField(title: "Short-term", amount: $ts.shortTermCapitalLosses).padding(0)
                        Divider()
                        CurrencyField(title: "Carryover", amount: $ts.capitalLossCarryOver).padding(0)
                    }
                    CardView {
                        HStack {
                            Text("Dividends")
                            Spacer()
                        }
                    } content: {
                        CurrencyField(title: "Qualified", amount: $ts.qualifiedDividends)
                        Divider()
                        CurrencyField(title: "Ordinary", amount: $ts.nonQualifiedDividends)
                    }
                    CardView {
                        HStack {
                            Text("Interest")
                            Spacer()
                        }
                    } content: {
                        CurrencyField(title: "Tax-Exempt Interest", amount: $ts.taxExemptInterest)
                        Divider()
                        CurrencyField(title: "Interest", amount: $ts.interest)
                    }
                    CardView {
                        HStack {
                            Text("Retirement")
                            Spacer()
                        }
                    } content: {
                        CurrencyField(title: "Roth Conversion", amount: $ts.rothConversion)
                        Divider()
                        CurrencyField(title: "IRA Withdrawal", amount: $ts.iraWithdrawal)
                    }
                    CardView {
                        HStack {
                            Text("Other Income")
                            Spacer()
                        }
                    } content: {
                        CurrencyField(title: "Rental Income", amount: $ts.rentalIncome)
                        Divider()
                        CurrencyField(title: "Royalties", amount: $ts.royalties)
                        Divider()
                        CurrencyField(title: "Business Income", amount: $ts.businessIncome)
                        Divider()
                        CurrencyField(title: "Foreign Earned Income (FEIE)", amount: $ts.foreignEarnedIncome)
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
