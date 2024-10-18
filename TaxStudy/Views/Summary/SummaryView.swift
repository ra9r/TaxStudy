//
//  ReportView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/9/24.
//
import SwiftUI

struct SummaryView : View {
    @Binding var ts: TaxScenario
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Header(ts: $ts)
                KeyFigures(federalTaxes: FederalTaxCalc(ts), stateTaxes: NCTaxCalc(ts))
            }
            .padding()
        }
        .frame(minWidth: 800)
    }
}
