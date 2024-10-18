//
//  DeductionsView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/14/24.
//

import SwiftUI

struct DeductionsView: View {
    @Binding var ts: TaxScenario
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top, spacing: 10) {
                DeductionEditor("Adjustments", $ts.adjustments)
                DeductionEditor("Deductions", $ts.deductions)
                DeductionEditor("Credits", $ts.credits)
            }
            .padding()
        }
        .frame(minWidth: 800)
    }
}

#Preview {
    @Previewable @State var manager = TaxScenarioManager()
    DeductionsView(ts: $manager.selectedTaxScenario)
        .environment(manager)
        .onAppear() {
            do {
                try manager.open(from: URL(fileURLWithPath: "/Users/rodney/Desktop/2024EstimatedTax.json"))
            } catch {
                print(error)
            }
        }
}
