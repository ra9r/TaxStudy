import SwiftUI

struct SortableVStackView: View {
    @State private var items: [BudgetItem] = [
        .init(label: "Rent", value: "$2,150.00"),
        .init(label: "Utilities", value: "$115.00"),
        .init(label: "Car Insurance", value: "$424.00"),
        .init(label: "Car Loan", value: "$884.16"),
        .init(label: "Mobile Service", value: "$122.00"),
        .init(label: "Internet Service", value: "$100.00"),
        .init(label: "Medical Insurance", value: "$1,750.00"),
        .init(label: "Groceries", value: "$769.00"),
    ]
    @State private var draggingItem: BudgetItem?
    
    var body: some View {
        ScrollView {
            VStack {
                let columns = Array(repeating: GridItem(spacing: 2), count: 1)
                LazyVGrid(columns: columns, spacing: 2) {
                    ReorderableForEach(items, active: $draggingItem) { item in
                        ToggleLineItem(label: item.label, value: item.value)
                    } moveAction: { from, to in
                        items.move(fromOffsets: from, toOffset: to)
                    }
                }
            }
            .frame(minWidth: 400)
        }
    }
}

private struct BudgetItem : Codable, Identifiable, Transferable, Equatable {
    
    var id: UUID = UUID()
    var label: String
    var value: String
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .json)
    }
}

private struct ToggleLineItem : View {
    @State var toggleOn = false
    var label: String
    var value: String
    var body: some View {
        HStack {
            Toggle(label, isOn: $toggleOn)
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
            Text(value)
                .font(.headline)
                .fontWeight(.regular)
            
        }
        .padding()
        .background(.white)
    }
}

#Preview {
    SortableVStackView()
}
