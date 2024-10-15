//
//  ReportView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/9/24.
//
import SwiftUI

struct SummaryView : View {
    @Binding var ts: TaxScenario
    //    @State var item: Int = 1
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Header(ts: $ts)
                MetaHeaderView(ts)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                DataGridView(ts)
                
            }
            .padding()
            
            
        }
        .frame(minWidth: 800)
    }
    
    
    
    
    
    
    
    
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var manager = TaxScenarioManager()
    SummaryView(ts: $manager.selectedTaxScenario)
        .frame(minWidth: 1000, minHeight: 800)
        .onAppear() {
            do {
                try manager.open(from: URL(fileURLWithPath: "/Users/rodney/Desktop/2024EstimatedTax.json"))
            } catch {
                print(error)
            }
        }
}
