//
//  CompareScenariosView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/9/24.
//

import SwiftUI

struct CompareScenariosView : View {
    @Environment(TaxSchemeManager.self) var taxSchemeManager
    @Binding var scenarios: Set<TaxScenario>
    @Binding var reportConfig: ReportConfig

    var gridItems: [GridItem] {
        var items: [GridItem] = [] // Header column
        let numberOfColumns = scenarios.count
        items.append(contentsOf: Array(repeating: GridItem(.flexible()), count: numberOfColumns))
        return items
    }
    
    var body: some View {
        ScrollView {
            Grid(alignment: .leading, horizontalSpacing: 5, verticalSpacing: 0) {
                ForEach(reportConfig.compareReport, id: \.id) { reportSection in
                    GridRow {
                        HStack {
                            Text(reportSection.title)
                                .textCase(.uppercase)
                            Spacer()
                            PopoverMenu {
                                Button("Add Metric") {
                                    print("Add Metric")
                                }
                                
                                Button("Add Section") {
                                    print("Add Section")
                                }
                                Button("Add Chart") {
                                    print("Add Chart")
                                }
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                        .font(.system(size: 14, weight: .regular))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .gridCellColumns(scenarios.count + 1)
                        .background(.accent)
                        .foregroundColor(.white)
                    }
                    ForEach(reportSection.items, id: \.id) { reportItem in
                        if let index = reportSection.items.firstIndex(where: { $0.id == reportItem.id }) {
                            GridRow {
                                ReportItemRow(reportItem, color: rowColor(index))
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
    }
    
    func rowColor(_ index: Int) -> Color {
        return index % 2 == 0 ? Color.accentColor.opacity(0.1) : Color.white
    }
    
    func HeaderItemRow(_ title: String) -> some View {
        ForEach(Array(scenarios), id: \.self) { scenario in
            Text(title)
                .font(.title)
        }
    }
    
    @ViewBuilder
    func ReportItemRow(_ item: ReportItem, color: Color) -> some View {
        HStack {
            Spacer()
            Text(item.label)
                .padding(.horizontal, 10)
                .font(.system(size: 12, weight: .semibold))
                .multilineTextAlignment(.trailing)
        }
        .frame(maxWidth: 150)
        ForEach(Array(scenarios), id: \.self) { scenario in
            item.content(scenario: scenario,
                         taxScheme: taxSchemeManager.selectedScheme,
                         compact: true)
            .background(color)
        }
    }
}

struct PopoverMenu<Label: View, Content: View>: View {
    @State private var isPresented = false
    let label: Label
    let content: Content

    init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder label: @escaping () -> Label) {
        self.content = content()
        self.label = label()
    }

    var body: some View {
        Button(action: {
            isPresented.toggle()
        }) {
            label
        }
        .buttonStyle(.plain)
        .popover(isPresented: $isPresented, arrowEdge: .bottom) {
            VStack(alignment: .leading, spacing: 10) {
                content
                    .buttonStyle(.borderedProminent)
            }
//            .padding()
            .frame(width: 150) // Customize the size of the popover
        }
    }
}
