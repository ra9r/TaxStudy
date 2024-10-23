//
//  KeyMetricsLayoutEditor.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/23/24.
//

import SwiftUI

struct KeyMetricsLayoutEditor {
    @Binding var selectedKeyMetrics: [KeyMetricTypes]
    var body: some View {
        List {
            ForEach(selectedKeyMetrics, id: \.self) { keyMetrics in
                Text(keyMetrics.label)
            }
            .onMove(perform: move)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        selectedKeyMetrics.move(fromOffsets: source, toOffset: destination)
    }
}
