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
                header
                MetaHeaderView(ts)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                DataGridView(ts)
                
            }
            .padding()
            
            
        }
        .frame(minWidth: 800)
    }
    
    
    
    var header: some View {
        HStack(alignment: .top, spacing: 25) {
            blueBox
            nameAndDescription
            Spacer()
        }
    }
    
    var blueBox: some View {
        HStack {
            Text("2024")
                .font(.largeTitle)
            Divider()
            VStack(alignment: .trailing) {
                Text("\(ts.grossIncome.asCurrency)")
                    .font(.headline)
                Text("Gross Income")
                    .font(.subheadline)
            }
        }
        .frame(minWidth: 200)
        .padding()
        .foregroundStyle(.white)
        .background(.accent)
        .cornerRadius(5)
    }
    
    var nameAndDescription: some View {
        VStack(alignment: .leading) {
            TextField("name", text: $ts.name)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.title)
                .multilineTextAlignment(.leading)
            TextEditor(text: $ts.description)
                .textEditorStyle(.plain)
                .scrollDisabled(true)
                .lineLimit(3)
                .font(.subheadline)
                .padding(.leading, -5) // <-- This seems like a hack :(
                .multilineTextAlignment(.leading)
        }
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
