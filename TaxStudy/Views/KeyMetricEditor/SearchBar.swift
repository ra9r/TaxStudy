//
//  SearchBar.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/14/24.
//
import SwiftUI

// A basic search bar component using a TextField
struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search key metrics", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}
