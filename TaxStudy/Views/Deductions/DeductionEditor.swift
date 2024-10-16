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
                Button(action: {
                    showDescription.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                    //                        .font(.system(size: 18, weight: .bold))
                }
                .buttonStyle(PlainButtonStyle())
                .popover(isPresented: $showDescription, arrowEdge: .top) {
                    addDeductionPopup
                        .padding(10)
                }
            }
        } content: {
            ForEach(deductions.items.indices, id: \.self) { index in
                CardField(deductions.items[index].type.label,
                              amount: $deductions.items[index].amount)
                
                if index != deductions.items.indices.last {
                    Divider()
                }
            }
        }
    }
    
    var addDeductionPopup: some View {
        VStack {
            Picker("Select", selection: $selected) {
                Text("- Select -").tag(nil as T?)
                ForEach(T.allCases, id: \.self) { deductionType in
                    Text(deductionType.label) // Display the localized label for each case
                        .tag(deductionType)
                }
            }
            .labelsHidden()
            .pickerStyle(.automatic) // You can change the style as needed
            TextField("Enter amount", value: $amount, format: .currency(code: "USD"))
                .multilineTextAlignment(.trailing)
                .frame(width: 100)
            HStack(spacing: 5) {
                Button {
                    showDescription.toggle()
                } label: {
                    Text("Cancel")
                }
                Button {
                    if let selected {
                        deductions.add(.init(selected, amount: amount))
                    }
                } label: {
                    Text("Add")
                }
            }
        }
    }
}

