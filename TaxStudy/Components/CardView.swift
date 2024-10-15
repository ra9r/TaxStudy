//
//  CardView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/15/24.
//

import SwiftUI

struct CardView<Header: View, Content: View>: View {
    let header: Header
    let content: Content

    init(@ViewBuilder header: () -> Header, @ViewBuilder content: () -> Content) {
        self.header = header()
        self.content = content()
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    header
                }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 5)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                    .background(.accent)
                    .foregroundColor(.white)
                
                content
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
    CardView {
        HStack {
            Text("Title goes here")
                .padding(.vertical, 10)
                .padding(.horizontal, 5)
                .font(.headline)
            Spacer()
        }
    } content: {
        VStack {
            HStack {
                Text("Line Value")
                    .font(.subheadline)
                
                Spacer()
                
                Text("$80,000")
                    .font(.subheadline)
            }
            .padding(2.5)
            Divider()
            HStack {
                Text("Line Value")
                    .font(.subheadline)
                
                Spacer()
                
                Text("$80,000")
                    .font(.subheadline)
            }
            .padding(2.5)
            Divider()
            HStack {
                Text("Line Value")
                    .font(.subheadline)
                
                Spacer()
                
                Text("$80,000")
                    .font(.subheadline)
            }
            .padding(2.5)
            Divider()
            HStack {
                Text("Line Value")
                    .font(.subheadline)
                
                Spacer()
                
                Text("$80,000")
                    .font(.subheadline)
            }
            .padding(2.5)
        }
    }
    .padding()
}
