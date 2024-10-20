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
                    CardItem("Self", value: scenario.profileSelf.name)
                    CardItem("Spouse", value: scenario.profileSpouse.name)
                }
                Divider()
                VStack(alignment: .leading) {
                    CardNumberField("Age", amount: $scenario.profileSelf.age)
                    CardNumberField("Age", amount: $scenario.profileSpouse.age)
                }
                Divider()
                VStack(alignment: .leading) {
                    CardPicker("Employment Status", selection: $scenario.profileSelf.employmentStatus)
                    CardPicker("Employment Status", selection: $scenario.profileSpouse.employmentStatus)
                }
                Divider()
                VStack(alignment: .leading) {
                    CardCurrencyField("Wages", amount: $scenario.profileSelf.wages)
                    CardCurrencyField("Wages", amount: $scenario.profileSpouse.wages)
                    
                }
                Divider()
                VStack(alignment: .leading) {
                    CardCurrencyField("Social Security", amount: $scenario.profileSelf.socialSecurity)
                    CardCurrencyField("Social Security", amount: $scenario.profileSpouse.socialSecurity)
                }
            }
        }
        //        .frame(maxHeight: 100)
    }
}

