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
        HStack {
            DeductionEditor(deductions: $ts.adjustments)
            DeductionEditor(deductions: $ts.deductions)
        }
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
