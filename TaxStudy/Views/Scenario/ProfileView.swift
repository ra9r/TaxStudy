//
//  Profiles.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var scenario: TaxScenario
    
    init(_ scenario: Binding<TaxScenario>) {
        self._scenario = scenario
    }
    
    var body: some View {
        CardView("Profiles") {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    CardTextField("Self", value: $scenario.profileSelf.name)
                    if scenario.filingStatus == .marriedFilingJointly {
                        CardTextField("Spouse", value: $scenario.profileSpouse.name)
                    }
                }
                Divider()
                VStack(alignment: .leading) {
                    CardNumberField("Age", amount: $scenario.profileSelf.age)
                    if scenario.filingStatus == .marriedFilingJointly {
                        CardNumberField("Age", amount: $scenario.profileSpouse.age)
                    }
                }
                .frame(maxWidth: 100)
                Divider()
                VStack(alignment: .leading) {
                    CardPicker("Employment", selection: $scenario.profileSelf.employmentStatus)
                    if scenario.filingStatus == .marriedFilingJointly {
                        CardPicker("Employment", selection: $scenario.profileSpouse.employmentStatus)
                    }
                }
                Divider()
                VStack(alignment: .leading) {
                    CardCurrencyField("Wages", amount: $scenario.profileSelf.wages)
                    if scenario.filingStatus == .marriedFilingJointly {
                        CardCurrencyField("Wages", amount: $scenario.profileSpouse.wages)
                    }
                    
                }
                Divider()
                VStack(alignment: .leading) {
                    CardCurrencyField("SSA Benefits", amount: $scenario.profileSelf.socialSecurity)
                    if scenario.filingStatus == .marriedFilingJointly {
                        CardCurrencyField("SSA Benefits", amount: $scenario.profileSpouse.socialSecurity)
                    }
                }
                Divider()
                VStack(alignment: .leading) {
                    CardPicker("Medical", selection: $scenario.profileSelf.medicalCoverage)
                    if scenario.filingStatus == .marriedFilingJointly {
                        CardPicker("Medical", selection: $scenario.profileSpouse.medicalCoverage)
                    }
                }
            }
        }
        //        .frame(maxHeight: 100)
    }
}

