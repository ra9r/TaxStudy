//
//  DeductionFactsEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/28/24.
//

import SwiftUI

struct DescribedContainer<Content: View> : View {
    var title: String
    var description: String? = nil
    var content: Content
    
    init(_ title: String, description: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.description = description
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                if let description {
                    Text(description)
                        .frame(maxWidth: 600, alignment: .leading)  // Fills the horizontal space
                        .multilineTextAlignment(.leading)                 // Aligns text to the leading edge
                        .lineLimit(20)
                }

                Divider()
                
                content
                
            }
        }
    }
}

#Preview {
    @Previewable @State var facts: TaxFacts = TaxFacts.official2024
    DescribedContainer("Net Investment Income Tax (NIIT)",
    description: "The Net Investment Income Tax (NIIT) is a tax on certain investment income for individuals, estates, and trusts. It applies to those with modified adjusted gross income (MAGI) above specific thresholds based on filing status.")
    {
        Text("Content Goes here")
    }
}
