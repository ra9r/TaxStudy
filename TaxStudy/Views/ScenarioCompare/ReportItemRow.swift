//
//  ReportItemRow.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 12/5/24.
//

import SwiftUI

struct ReportItemRow :  View {
    @Environment(TaxSchemeManager.self) var taxSchemeManager
    
    var item: ReportItem
    @Binding var scenarios: Set<TaxScenario>
    
    var body : some View {
        HStack {
            Spacer()
            Text(item.label)
                .padding(.horizontal, 10)
                .font(.system(size: 12, weight: .semibold))
                .multilineTextAlignment(.trailing)
        }
        .frame(maxWidth: 150)
        ForEach(Array(scenarios), id: \.self) { scenario in
            item.content(scenario: scenario,
                         taxScheme: taxSchemeManager.selectedScheme,
                         compact: true)
        }
    }
}

