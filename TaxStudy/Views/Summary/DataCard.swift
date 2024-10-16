//
//  DataView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/12/24.
//

import SwiftUI

struct DataCard: View {
    var title: String
    let data: [(String, String)]
    
    init(_ title: String, _ data: [(String, String)]) {
        self.title = title
        self.data = data
    }
    
    var body: some View {
        CardView(title) {
            ForEach(data.indices, id: \.self) { index in
                CardItem(data[index].0, value: data[index].1)
                
                if index != data.indices.last {
                    Divider()
                }
            }
        }
    }
}

#Preview {
    DataCard("Fund Basics", [
        ("Fund sponsor", "Vanguard Group"),
        ("Category", "Aggregate"),
        ("Asset class", "Fixed Income"),
        ("Website", "link..."),
        ("Inception date", "Apr 03, 2007"),
        ("Assets (mns)", "$116,662"),
        ("Expense ratio", "3 bp")])
    .frame(width: 350)
    
}

