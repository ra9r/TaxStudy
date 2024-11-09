//
//  Profiles.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//

import SwiftUI

struct ProfileView: View {
//    var facts: [TaxFacts]
    @Binding var scenario: TaxScenario
     
    var body: some View {
        CardView("Profiles") {
            let gridItems = [
                GridItem(.fixed(150), alignment: .leading), // Name
                GridItem(.fixed(100), alignment: .leading), // Age
                GridItem(.fixed(220), alignment: .leading), // Employment
                GridItem(.flexible(), alignment: .leading), // Wages
                GridItem(.flexible(), alignment: .leading), // SSA Benefits
                GridItem(.flexible(), alignment: .leading), // Medical
            ]
            LazyVGrid(columns: gridItems) {
                CardTextField("", symbol: "person", value: $scenario.profileSelf.name)
                CardNumberField("Age", amount: $scenario.profileSelf.age)
                CardPicker("Employment", selection: $scenario.profileSelf.employmentStatus)
                CardCurrencyField("Wages", amount: $scenario.profileSelf.wages)
                CardCurrencyField("SSA Benefits", amount: $scenario.profileSelf.socialSecurity)
                CardPicker("Medical", selection: $scenario.profileSelf.medicalCoverage)
                if scenario.filingStatus == .marriedFilingJointly {
                    CardTextField("", symbol: "person.2", value: $scenario.profileSpouse.name)
                    CardNumberField("Age", amount: $scenario.profileSpouse.age)
                    CardPicker("Employment", selection: $scenario.profileSpouse.employmentStatus)
                    CardCurrencyField("Wages", amount: $scenario.profileSpouse.wages)
                    CardCurrencyField("SSA Benefits", amount: $scenario.profileSpouse.socialSecurity)
                    CardPicker("Medical", selection: $scenario.profileSpouse.medicalCoverage)
                }
            }
        }
    }
}

