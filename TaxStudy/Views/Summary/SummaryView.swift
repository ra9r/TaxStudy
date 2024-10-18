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
                MetaHeaderView(ts)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
            }
            .padding()
            
            
        }
        .frame(minWidth: 800)
    }
}
