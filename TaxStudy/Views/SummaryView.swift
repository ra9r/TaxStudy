//
//  ReportView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/9/24.
//
import SwiftUI

struct SummaryView : View {
    var ts: TaxScenario
    //    @State var item: Int = 1
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                header
                HStack(alignment: .top) {
                    incomeSources
                    computedResults
                }
                
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
        }
        .frame(minWidth: 800)
    }
    
    var header: some View {
        HStack(alignment: .top) {
            blueBox
            nameAndDescription
        }
    }
    
    var blueBox: some View {
        HStack {
            Text("2024")
                .font(.largeTitle)
            Divider()
            VStack(alignment: .leading) {
                Text("\(ts.grossIncome.asCurrency)")
                    .font(.headline)
                Text("Gross Income")
                    .font(.subheadline)
            }
        }
        .padding()
        .foregroundStyle(.white)
        .background(Color.accentColor)
        .cornerRadius(5)
    }
    
    var nameAndDescription: some View {
        VStack(alignment: .leading) {
            Text("\(ts.name)")
                .font(.title)
            Text("\(ts.description)")
                .font(.subheadline)
        }
    }
    
    var incomeSources: some View {
        DataView("Income Sources", [
            ("Social Security", ts.totalSocialSecurityIncome.asCurrency),
            ("Long-term Capital Gains", ts.longTermCapitalGains.asCurrency),
            ("Long-term Capital Losses", ts.longTermCapitalLosses.asCurrency)
        ])
    }
    
    var computedResults: some View {
        DataView("Computed Results", [
            ("Federal Taxes", ts.federalTaxes.taxesOwed.asCurrency),
            ("State Taxes", ts.stateTaxes.taxesOwed.asCurrency),
            ("AGI (Before SS Income)", ts.federalTaxes.agiBeforeSSDI.asCurrency),
            ("AGI", ts.federalTaxes.agi.asCurrency)
        ])
    }
    
    
}

#Preview {
    @Previewable @State var manager = TaxScenarioManager()
    SummaryView(ts: manager.selectedTaxScenario)
        .onAppear() {
            do {
                try manager.open(from: URL(fileURLWithPath: "/Users/rodney/Desktop/2024EstimatedTax.json"))
            } catch {
                print(error)
            }
        }
}
