//
//  ThresholdEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/28/24.
//

import SwiftUI

struct ThresholdEditor: View {
    @Binding var thresholds: [FilingStatus: Double]
    
    var body: some View {
        VStack {
            ThresholdField(.single)
            ThresholdField(.marriedFilingJointly)
            ThresholdField(.marriedFilingSeparately)
            ThresholdField(.headOfHousehold)
            ThresholdField(.qualifiedWidow)
        }
        .padding()
        .frame(maxWidth: 300)
    }
    
    func ThresholdField(_ filingStatus: FilingStatus) -> some View {
        HStack {
            Spacer()
            Text(filingStatus.label)
            Text("$")
            TextField("Value", value: $thresholds[filingStatus], format: .number)
                .underlinedTextField()
        }
    }
}

#Preview {
    @Previewable @State var thresholds: [FilingStatus: Double] = [
        .single: 200_000,
        .marriedFilingJointly: 250_000,
        .marriedFilingSeparately: 125_000,
        .headOfHousehold: 200_000,
        .qualifiedWidow: 250_000
    ]
    ThresholdEditor(thresholds: $thresholds)
}
