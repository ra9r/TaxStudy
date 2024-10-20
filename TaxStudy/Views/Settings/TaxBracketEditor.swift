//
//  TaxBracketEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/16/24.
//

import SwiftUI

struct TaxBracketEditor: View {
    @State var internalTaxBrackets: [InternalTaxBracket] = []
    @State var selection: Set<InternalTaxBracket.ID> = []
    
    init(_ taxBrackets: [FilingStatus: TaxBrackets]) {
        var ib: [InternalTaxBracket] = []
        if let brackets = taxBrackets[.single] {
            for bracket in brackets.brackets {
                ib.append(InternalTaxBracket(rate: bracket.rate, singleThreshold: bracket.threshold))
            }
        }
        if let brackets = taxBrackets[.marriedFilingJointly] {
            for bracket in brackets.brackets {
                if let internalBracket = ib.first(where: { bracket.rate == $0.rate}) {
                    internalBracket.marriedFilingJointlyThreadold = bracket.threshold
                }
            }
        }
        if let brackets = taxBrackets[.marriedFilingSeparately] {
            for bracket in brackets.brackets {
                if let internalBracket = ib.first(where: { bracket.rate == $0.rate}) {
                    internalBracket.marriedFilingSeparatelyThreadold = bracket.threshold
                }
            }
        }
        if let brackets = taxBrackets[.headOfHousehold] {
            for bracket in brackets.brackets {
                if let internalBracket = ib.first(where: { bracket.rate == $0.rate}) {
                    internalBracket.headOfHouseholdThreadold = bracket.threshold
                }
            }
        }
        if let brackets = taxBrackets[.qualifiedWidow] {
            for bracket in brackets.brackets {
                if let internalBracket = internalTaxBrackets.first(where: { bracket.rate == $0.rate}) {
                    internalBracket.qualifiedWidowThreadold = bracket.threshold
                }
            }
        }
        self.internalTaxBrackets = ib
    }
    
    var body: some View {
        VStack {
            Table(internalTaxBrackets, selection: $selection) {
                TableColumn("Tax Rate", value: \.rate.asPercentage)
                TableColumn("Single", value: \.singleThreshold.asCurrency)
                TableColumn("Married Filing Jointly", value: \.marriedFilingJointlyThreadold.asCurrency)
                TableColumn("Married Filing Separate", value: \.marriedFilingSeparatelyThreadold.asCurrency)
                TableColumn("Head of Houshold", value: \.headOfHouseholdThreadold.asCurrency)
                TableColumn("Qualified Widow(er)", value: \.qualifiedWidowThreadold.asCurrency)
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

#Preview {
    @Previewable @State var manager = AppData()
    TaxBracketEditor(DefaultTaxFacts2024.ordinaryTaxBrackets)
        .environment(manager)
}
