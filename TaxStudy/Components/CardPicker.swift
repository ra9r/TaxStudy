//
//  CardPicker.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/18/24.
//

import SwiftUI

struct CardPicker<T: CaseIterable & Hashable & Displayable>: View {
    var label: String
    @Binding var selection: T

    init(_ label: String, selection: Binding<T>) {
        self.label = label
        self._selection = selection
    }

    var body: some View {
        HStack(alignment: .center) {
            HStack {
                Text(label)
                    .font(.system(size: 12, weight: .semibold))

                Spacer()

                Menu {
                    ForEach(Array(T.allCases), id: \.self) { option in
                        Button("\(option.label)"){
                            selection = option
                        }
                    }
                } label: {
                    Spacer()
                    Text("\(selection.label)")
                        .decorated(by: "chevron.down")
//                        .multilineTextAlignment(.trailing)
//                        .font(.system(size: 12, weight: .medium))
//                        .foregroundColor(.gray)
//                        .overlay(Rectangle()
//                            .frame(height: 1) // Thin underline
//                            .foregroundColor(.gray.opacity(0.5)), // Line color
//                                 alignment: .bottom
//                        )
//                    Image(systemName: "chevron.up.chevron.down.square.fill")
//                        .foregroundColor(.accent)
                }
                .buttonStyle(PlainButtonStyle())
                .frame(maxWidth: .infinity)
            }
            .padding(2.5)
        }
    }
}

