//
//  CardPicker.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/18/24.
//

import SwiftUI

struct CardPicker<T: CaseIterable & Hashable & RawRepresentable>: View {
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
                        Button("\(option.rawValue)"){
                            selection = option
                        }
                    }
                } label: {
                    Text("\(selection.rawValue)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
                .buttonStyle(PlainButtonStyle())
//                .frame(width: 200)
            }
            .padding(2.5)
        }
    }
}

