//
//  PercentageCard.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/30/24.
//

import SwiftUI

struct PercentageCard: View {
    var title: String
    var value: Double
    
    func format(_ value: Double) -> String {
        return String(format: "%.2f%%", value * 100)
    }

    var body: some View {
        GroupBox {
            VStack {
                Text(title)
                Text(format(value))
                    .font(.largeTitle)
            }
            .padding()
        }
    }
}
