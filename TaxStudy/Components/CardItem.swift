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
    var compact: Bool
    
    init(_ label: String, value: String, compact: Bool = false) {
        self.label = label
        self.value = value
        self.compact = compact
    }
    
    var body: some View {
        HStack {
            if compact == false {
                Text(label)
                    .font(.system(size: 12, weight: .semibold))
            }
            Spacer()
            
            Text(value)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.gray)
                .multilineTextAlignment(.trailing)
        }
        .padding(2.5)
    }
}

#Preview(traits: .fixedLayout(width: 300, height: 600)) {
    VStack {
        CardItem("Label", value: "Value")
        CardItem("Label", value: "Value")
        CardItem("Label", value: "Value")
        CardItem("Label", value: "Value")
    }
}
