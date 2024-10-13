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
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(title)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 5)
                        .font(.headline)
                    Spacer()
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
                .background(.accent)
                .foregroundColor(.white)
                
                
                VStack {
                    ForEach(data.indices, id: \.self) { index in
                        HStack {
                            Text(data[index].0)
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Text(data[index].1)
                                .font(.subheadline)
                        }
                        .padding(2.5)
                        
                        if index != data.indices.last {
                            Divider()
                        }
                    }
                }
                .padding(.bottom, 15)
                .padding(.horizontal, 5)
            }
            
        }
        .background(.gray.opacity(0.1))
        .frame(minWidth: 350)
        .cornerRadius(5)
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

