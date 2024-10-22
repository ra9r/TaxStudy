//
//  TaxFactsImportView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/21/24.
//
import SwiftUI

struct TaxFactsImportView : View {
    @Binding var document: TaxFactsDocument
    
    init(_ document: Binding<TaxFactsDocument>) {
        self._document = document
    }
    
    var body: some View {
        Text("Import \(document.facts.count) TaxFacts?")
    }
}
