//
//  TaxBracketEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/16/24.
//

import SwiftUI

struct TaxBracketEditor: View {
    var taxBrackets: TaxBrackets
    @State var selection: Set<TaxBracket.ID> = []
    
    
    var body: some View {
        VStack {
            Table(taxBrackets.brackets, selection: $selection) {
                TableColumn("Tax Rate", value: \.rate.asPercentage)
                TableColumn("Single", value: \.thresholds[.single]!.asCurrency)
                TableColumn("Married Filing Jointly", value: \.thresholds[.marriedFilingJointly]!.asCurrency)
                TableColumn("Married Filing Separate", value: \.thresholds[.marriedFilingSeparately]!.asCurrency)
                TableColumn("Head of Houshold", value: \.thresholds[.headOfHousehold]!.asCurrency)
                TableColumn("Qualified Widow(er)", value: \.thresholds[.qualifiedWidow]!.asCurrency)
            }
            
            // Add New Tax Bracket Button
            Button(action: {
                print("Clicked!")
            }) {
                Text("Add New Tax Bracket")
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

class InternalTaxBracket : Identifiable {
    var id: UUID = UUID()
    var rate: Double = 0
    var singleThreshold: Double = 0
    var marriedFilingJointlyThreadold: Double = 0
    var marriedFilingSeparatelyThreadold: Double = 0
    var headOfHouseholdThreadold: Double = 0
    var qualifiedWidowThreadold: Double = 0
    
    init(
        rate: Double,
        singleThreshold: Double,
        marriedFilingJointlyThreadold: Double = 0,
        marriedFilingSeparatelyThreadold: Double = 0,
        headOfHouseholdThreadold: Double = 0,
        qualifiedWidowThreadold: Double = 0
    ) {
        self.rate = rate
        self.singleThreshold = singleThreshold
        self.marriedFilingJointlyThreadold = marriedFilingJointlyThreadold
        self.marriedFilingSeparatelyThreadold = marriedFilingSeparatelyThreadold
        self.headOfHouseholdThreadold = headOfHouseholdThreadold
        self.qualifiedWidowThreadold = qualifiedWidowThreadold
    }
}
