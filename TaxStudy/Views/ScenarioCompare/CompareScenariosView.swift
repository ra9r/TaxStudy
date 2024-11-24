//
//  CompareScenariosView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/9/24.
//

import SwiftUI

struct CompareScenariosView : View {
    @Environment(TaxSchemeManager.self) var taxSchemeManager
    @Binding var scenarios: Set<TaxScenario>
    @Binding var reportConfig: ReportConfig

    
    var body: some View {
        VStack {
            HStack {
                ForEach(Array(scenarios), id: \.id) { scenario in
                    VStack {
                        if let selectedTaxScheme = taxSchemeManager.allTaxSchemes().first(where: { $0.id == scenario.taxSchemeId}) {
                            ForEach(reportConfig.compareReport, id: \.id) { section in
                                CardView(section.title) {
                                    ReportItemStack(
                                        items: section.items,
                                        taxScheme: selectedTaxScheme,
                                        scenario: scenario)
                                    .padding(.bottom, 10)
                                }
                            }
                        } else {
                            Text("No Tax Scheme Assigned")
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}
