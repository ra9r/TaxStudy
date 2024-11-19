//
//  CardView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/15/24.
//

import SwiftUI

struct CardView<Content: View>: View {
    let header: AnyView
    let content: Content

    init<Header: View>(@ViewBuilder header: () -> Header, @ViewBuilder content: () -> Content) {
        self.header = AnyView(header())
        self.content = content()
    }
    
    // New convenience initializer
    init(_ headerLabel: String, @ViewBuilder content: () -> Content) {
        self.header = AnyView(
            HStack {
                Text(headerLabel)
                Spacer()
            }
        )
        self.content = content()
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                header
                    .textCase(.uppercase)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .font(.system(size: 14, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                    .background(.accent)
                    .foregroundColor(.white)
                content
            }
            
        }
        .background(.altBackground.opacity(0.2))
        .frame(minWidth: 250)
        .cornerRadius(5)
    }
}

#Preview {
    CardView("Title goes here") {
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
