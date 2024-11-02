//
//  ThresholdEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/1/24.
//
import SwiftUI

struct ThresholdEditor : View {
    var thresholds: Binding<[FilingStatus : Double]>
    
    var body: some View {
        Threashold(.single)
        Threashold(.marriedFilingJointly)
        Threashold(.marriedFilingSeparately)
        Threashold(.headOfHousehold)
        Threashold(.qualifiedWidow)
    }
    
    func Threashold(_ filingStatus: FilingStatus) -> some View {
        Group {
            Text(filingStatus.label).font(.headline)
            TextField("Value", value: thresholds[filingStatus], format: .number)
                .decorated(by: "dollarsign")
        }
    }
}
