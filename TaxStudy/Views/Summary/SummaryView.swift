//
//  ReportView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/9/24.
//
import SwiftUI

struct SummaryView : View {
    @Binding var scenario: TaxScenario
    
    init(_ scenario: Binding<TaxScenario>) {
        self._scenario = scenario
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Header($scenario)
                KeyFigures($scenario)
                ProfileView($scenario)
            }
            .padding()
        }
        .frame(minWidth: 800)
    }
}
