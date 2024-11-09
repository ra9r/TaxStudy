//
//  GeneralEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/5/24.
//

import SwiftUI

struct GeneralEditor : View {
    @Binding var taxScheme: TaxScheme
    
    var body: some View {
        DescribedContainer(
            "General Infomation",
            description: "This is the general information about these Tax Facts that help identify the year its designed for and any other notes.")
        {
            let gridItems = [
                GridItem(.fixed(100), alignment: .topTrailing),
                GridItem(.flexible(), alignment: .leading),
            ]
            
            LazyVGrid(columns: gridItems, spacing: 10) {
                Text("Year").font(.headline)
                TextField("Year", value: $taxScheme.year, formatter: YearFormatter())
                    .decorated(by: "calendar")
                    .frame(maxWidth: 200)
                Text("Name").font(.headline)
                TextField("Name", text: $taxScheme.name)
                    .decorated(by: "info.circle")
                    .frame(maxWidth: 200)
                Text("Notes").font(.headline)
                TextEditor(text: $taxScheme.notes)
                    .decorated()
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .padding()
        .onChange(of: taxScheme) {
            print("Change to facts")
        }
    }
}

#Preview {
    @Previewable @State var facts: TaxScheme = TaxScheme.official2024
    GeneralEditor(taxScheme: $facts)
}

class YearFormatter: NumberFormatter, @unchecked Sendable {
    override init() {
        super.init()
        self.numberStyle = .none // Use plain number style
        self.minimumIntegerDigits = 4 // Ensure at least 4 digits
        self.maximumIntegerDigits = 4 // Limit to exactly 4 digits
        self.usesGroupingSeparator = false // Disable commas
        self.allowsFloats = false // Disallow decimals
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
