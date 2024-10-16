//
//  CardItem.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/15/24.
//

import SwiftUI

struct CardItem: View {
    var label: String
    var value: String
    
    init(_ label: String, value: String) {
        self.label = label
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
        }
        .padding(2.5)
    }
}
