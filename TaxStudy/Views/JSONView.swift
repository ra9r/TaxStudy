//
//  JSONView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/9/24.
//

import SwiftUI

struct JSONView: View {
    var taxScenario: TaxScenario
    public var body: some View {
        ScrollView {
            Text(String.prettyPrint(taxScenario) ?? "No Data")
                .frame(maxWidth: .infinity, alignment: .leading) // Forces the Text to fill the width
                                .padding()
        }
    }
}
