//
//  ReportEditorView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 11/24/24.
//
import SwiftUI

struct KeyMetricEditorView: View {
    @Binding var metrics: [KeyMetricTypes]
    @State var draggingItem: KeyMetricTypes?
    
    var body: some View {
        ScrollView {
            VStack {
                let columns = Array(repeating: GridItem(spacing: 2), count: 1)
                LazyVGrid(columns: columns, spacing: 0) {
                    KeyMetricList()
                    Divider().padding(4)
                    AddButton()
                }
                .padding(4)
            }
            .frame(minWidth: 400)
        }
    }
    
    func KeyMetricList() -> some View {
        ReorderableForEach(metrics, active: $draggingItem) { metric in
            HStack {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 8, weight: .bold))
                    .foregroundStyle(.gray.opacity(0.8))
                    .padding(0)
                Text(metric.label)
                Spacer()
                Button {
                    metrics.removeAll(where: { $0.id == metric.id })
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 10))
                        .foregroundStyle(.gray.opacity(0.8))
                }
                .buttonStyle(.plain)
            }
            .padding(4)
        } moveAction: { from, to in
            metrics.move(fromOffsets: from, toOffset: to)
        }
    }
    
    func AddButton() -> some View {
        HStack {
            Button {
                
            } label: {
                Spacer()
                Image(systemName: "plus")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.gray.opacity(0.8))
                    .padding(0)
                Text("Add Key Metric")
            }
            .buttonStyle(.plain)
        }
        .padding(4)
    }
}

#Preview {
    @Previewable @State var metrics: [KeyMetricTypes] = KeyMetricCategories.adjustments.types
    
    KeyMetricEditorView(metrics: $metrics)
}
