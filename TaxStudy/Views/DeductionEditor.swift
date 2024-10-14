//
//  DeductionEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/4/24.
//

//
//  ScenarioEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/28/24.
//

import SwiftUI

struct DeductionEditor: View {
    @Environment(TaxScenarioManager.self) var manager
    
    var body: some View {
        @Bindable var scenario = manager.selectedTaxScenario
        ScrollView {
            GroupBox("Deductions") {
                CurrencyField(title: "Margin Interest Expense", amount: $scenario.marginInterestExpense)
                CurrencyField(title: "Mortgage Interest Expense", amount: $scenario.mortgageInterestExpense)
                CurrencyField(title: "Medical and Dental Expense", amount: $scenario.medicalAndDentalExpense)
                CurrencyField(title: "Charitable Contribtuions", amount: $scenario.charitableContributions)
                CurrencyField(title: "DAF Contribtuions", amount: $scenario.dafContributions)
            }
        }
        .padding()
        .scrollIndicators(.never)
    }
    
}

