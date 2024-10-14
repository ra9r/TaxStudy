//
//  HorizontalBarChartView.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/14/24.
//

import SwiftUI
import Charts

// Data model for each category and its energy consumption
struct EnergyUsage: Identifiable {
    let id = UUID()
    var category: String
    var value: Double
    var color: Color
}

struct HorizontalBarChartView: View {
    let data: [EnergyUsage] = [
        EnergyUsage(category: "Cooling", value: 289, color: .blue), // Highlighted in blue
        EnergyUsage(category: "Lighting", value: 231, color: .gray),
        EnergyUsage(category: "Heating", value: 154, color: .gray),
        EnergyUsage(category: "Washing", value: 127, color: .gray),
        EnergyUsage(category: "Cooking", value: 70, color: .gray),
        EnergyUsage(category: "Dancing", value: 0, color: .gray)
    ]
    
    var body: some View {
        Chart(data) { entry in
            BarMark(
                x: .value("kWh", entry.value),  // The length of the bar (horizontal axis)
                y: .value("Category", entry.category) // The label for the category (vertical axis)
            )
            .foregroundStyle(entry.color) // Set the color of the bar
            .annotation(position: .leading, alignment: .leading) { // Display the category label to the left
                Text(entry.category)
                    .font(.caption)
                    .foregroundColor(.black)
            }
            .annotation(position: .overlay) { // Display the kWh value at the end of the bar
                Text("\(Int(entry.value)) kWh")
                    .font(.caption)
                    .foregroundColor(.black)
            }
        }
        .chartXScale(domain: 0...300)
        .chartXAxis {
            AxisMarks(position: .bottom) {
                AxisGridLine()  // Show vertical gridlines (hash lines)
                AxisTick()      // Axis ticks on the x-axis
                AxisValueLabel() // Labels for kWh
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) {
                AxisGridLine(stroke: StrokeStyle(lineWidth: 0)) // Remove horizontal gridlines
            }
        }
        .frame(height: 300)  // Adjust the chart height
        .padding(.leading, 100)
            
    }
}

#Preview {
    HorizontalBarChartView()
}

