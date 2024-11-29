import SwiftUI

struct MacGridCellColumnsExample: View {
    let data = Array(1...10)

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 10
            ) {
                ForEach(data, id: \.self) { item in
                    if item == 1 {
                        Text("Item \(item)")
                            .frame(minWidth: 200, minHeight: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .gridCellColumns(2) // Span 2 columns !!NOT WORKING!!
                    } else {
                        Text("Item \(item)")
                            .frame(height: 50)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .frame(width: 400)
    }
}

#Preview {
    MacGridCellColumnsExample()
}
