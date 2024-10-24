//
//  AppServices.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/19/24.
//

import SwiftUI

class AppServices : ObservableObject {
    @Binding var document: TaxProjectDocument
    
    init(document: Binding<TaxProjectDocument>) {
        self._document = document
    }
    
    func facts(for id: String) -> TaxFacts? {
        guard let fact = document.facts.first(where: { $0.id == id }) else {
            print("Error: No Fact Found for \(id)")
            return nil
        }
        return fact
    }
    
    func move(from source: IndexSet, to destination: Int) {
        document.scenarios.move(fromOffsets: source, toOffset: destination)
    }
}
