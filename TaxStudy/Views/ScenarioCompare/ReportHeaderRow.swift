//
//  ReportHeaderRow.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 12/5/24.
//

import SwiftUI

struct ReportHeaderRow: View {
    var reportSection: ReportSection
    var onAddSection: () -> Void
    var onAddChart: () -> Void
    var onAddMetrics: () -> Void
    
    var body: some View {
        HStack {
            Text(reportSection.title)
                .textCase(.uppercase)
            Spacer()
            Menu {
                Button("Add Section") {
                    onAddSection()
                }
                Button("Add Chart") {
                    onAddChart()
                }
                Button("Manage Metrics") {
                    onAddMetrics()
                }
            } label: {
                Image(systemName: "plus.circle.fill")
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .font(.system(size: 14, weight: .regular))
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(.accent)
        .foregroundColor(.white)
    }
}
