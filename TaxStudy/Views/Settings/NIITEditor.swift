//
//  NIITEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/28/24.
//

import SwiftUI

struct NIITEditor : View {
    @Binding var facts: TaxFacts
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Net Investment Income Tax (NIIT)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                Text("The Net Investment Income Tax (NIIT) is a tax on certain investment income for individuals, estates, and trusts. It applies to those with modified adjusted gross income (MAGI) above specific thresholds based on filing status.")
                    .frame(maxWidth: 600, alignment: .leading)  // Fills the horizontal space
                    .multilineTextAlignment(.leading)                 // Aligns text to the leading edge
                    .lineLimit(20)                                   // Allows the text to grow vertically
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Thresholds")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.bottom, 5)
                    Text("Specify the threshold amounts for each filing status.")
                        .frame(maxWidth: 600, alignment: .leading)  // Fills the horizontal space
                        .multilineTextAlignment(.leading)                 // Aligns text to the leading edge
                        .lineLimit(20)
                    ThresholdEditor(thresholds: $facts.niitThresholds)
                    
                    Text("Tax Rate")
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.bottom, 5)
                    Text("Specify the rate at which the NIIT will be computed.")
                        .frame(maxWidth: 600, alignment: .leading)  // Fills the horizontal space
                        .multilineTextAlignment(.leading)                 // Aligns text to the leading edge
                        .lineLimit(20)
                    VStack {
                        HStack {
                            Spacer()
                            Text("Rate")
                            Text("$")
                            TextField("Value", value: $facts.niitRate, format: .percent)
                                .underlinedTextField()
                        }
                    }
                    .padding()
                    .frame(maxWidth: 300)
                    
                }
                .padding(.top, 10)
            }
            .padding()
        }
    }
}

#Preview {
    @Previewable @State var facts: TaxFacts = createEmptyTaxFacts(id: "2024")
    NIITEditor(facts: $facts)
}
