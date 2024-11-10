//
//  DeductionEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/4/24.
//

//
//  ScenarioEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/28/24.
//

import SwiftUI

struct DeductionEditor<T : DeductionType & CaseIterable>: View where T.AllCases: RandomAccessCollection {
    var title: String
    @Binding var deductions: Deductions<T>
    @State private var showDescription: Bool = false
    @State private var amount: Double = 0
    @State private var selected: T? = nil
    
    init(_ title: String, _ deductions: Binding<Deductions<T>>) {
        self.title = title
        self._deductions = deductions
    }
    
    var body: some View {
        CardView {
            HStack {
                Text(title)
                
                Spacer()
                Menu {
                    ForEach(T.allCases, id: \.self) { incomeType in
                        Button(incomeType.label) {
                            deductions.add(.init(incomeType, amount: 0))
                        }
                        .disabled(incomeType.isSupported == false)
                    }
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .buttonStyle(PlainButtonStyle())
            }
        } content: {
            ForEach(deductions.items.indices, id: \.self) { index in
                CardCurrencyField(deductions.items[index].type.label,
                              amount: $deductions.items[index].amount)
                .help(deductions.items[index].type.description)
                .contextMenu {
                    Button("Delete") {
                        deductions.remove(deductions.items[index])
                    }
                }
                
//                if index != deductions.items.indices.last {
//                    Divider()
//                }
            }
        }
    }
}

