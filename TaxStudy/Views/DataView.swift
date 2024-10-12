//
//  DataView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/12/24.
//

import SwiftUI

struct DataView: View {
    var title: String
    let data: [(String, String)]
    
    init(_ title: String, _ data: [(String, String)]) {
        self.title = title
        self.data = data
    }
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 5)
                    .padding(.top, 10)
                
                Divider()
                
                ForEach(data, id: \.0) { item in
                    HStack {
                        Text(item.0)
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Text(item.1)
                            .font(.subheadline)
                    }
                    Divider()
                }
            }
            .padding()
        }
    }
}

#Preview {
    DataView("Fund Basics", [
        ("Fund sponsor", "Vanguard Group"),
        ("Category", "Aggregate"),
        ("Asset class", "Fixed Income"),
        ("Website", "link..."),
        ("Inception date", "Apr 03, 2007"),
        ("Assets (mns)", "$116,662"),
        ("Expense ratio", "3 bp")])
    .frame(width: 350)
    
}

