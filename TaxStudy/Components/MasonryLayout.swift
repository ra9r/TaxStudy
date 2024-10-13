//
//  MasonryLayout.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/13/24.
//

import SwiftUI

public struct MasonryHStack: Layout {

    private var rows: Int
    private var spacing: Double

    init(rows: Int = 2, spacing: Double = 8.0) {
        self.rows = rows
        self.spacing = spacing
    }

    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        return calculateSize(for: subviews, in: proposal)
    }

    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        calculateSize(for: subviews, in: proposal, placeInBounds: bounds)
    }

    @discardableResult
    private func calculateSize(
        for subviews: Subviews,
        in proposal: ProposedViewSize,
        placeInBounds bounds: CGRect? = nil
    ) -> CGSize {
        guard let maxHeight = proposal.height else { return .zero }
        let itemHeight = (maxHeight - spacing * Double(rows - 1)) / Double(rows)

        var yIndex: Int = 0
        var rowsWidths: [Double] = Array(repeating: bounds?.minX ?? 0, count: rows)

        subviews.forEach { view in
            let proposed = ProposedViewSize(
                width: view.sizeThatFits(.unspecified).width,
                height: itemHeight
            )

            if let bounds {
                let y = (itemHeight + spacing) * Double(yIndex) + bounds.minY
                view.place(
                    at: .init(x: rowsWidths[yIndex], y: y),
                    anchor: .topLeading,
                    proposal: proposed
                )
            }

            let width = view.dimensions(in: proposed).width
            rowsWidths[yIndex] += width + spacing
            let minimum = rowsWidths.enumerated().min {
                $0.element < $1.element
            }?.offset ?? 0
            yIndex = minimum
        }

        guard let maxWidth = rowsWidths.max() else { return .zero }

        return .init(
            width: maxWidth - spacing,
            height: maxHeight

        )
    }

    public static var layoutProperties: LayoutProperties {
        var properties = LayoutProperties()
        properties.stackOrientation = .horizontal
        return properties
    }

}

public struct MasonryVStack: Layout {

    private var columns: Int
    private var spacing: Double

    public init(columns: Int = 2, spacing: Double = 8.0) {
        self.columns = columns
        self.spacing = spacing
    }

    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        return calculateSize(for: subviews, in: proposal)
    }
    
    public func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        calculateSize(for: subviews, in: proposal, placeInBounds: bounds)
    }

    @discardableResult
    private func calculateSize(
        for subviews: Subviews,
        in proposal: ProposedViewSize,
        placeInBounds bounds: CGRect? = nil
    ) -> CGSize {
        guard let maxWidth = proposal.width else { return .zero }
        let itemWidth = (maxWidth - spacing * Double(columns - 1)) / Double(columns)

        var xIndex: Int = 0
        var columnsHeights: [Double] = Array(repeating: bounds?.minY ?? 0, count: columns)

        subviews.forEach { view in
            let proposed = ProposedViewSize(
                width: itemWidth,
                height: view.sizeThatFits(.unspecified).height
            )

            if let bounds {
                let x = (itemWidth + spacing) * Double(xIndex) + bounds.minX
                view.place(
                    at: .init(x: x, y: columnsHeights[xIndex]),
                    anchor: .topLeading,
                    proposal: proposed
                )
            }

            let height = view.dimensions(in: proposed).height
            columnsHeights[xIndex] += height + spacing
            let minimum = columnsHeights.enumerated().min {
                $0.element < $1.element
            }?.offset ?? 0
            xIndex = minimum
        }

        guard let maxHeight = columnsHeights.max() else { return .zero }

        return .init(
            width: maxWidth,
            height: maxHeight - spacing

        )
    }

    public static var layoutProperties: LayoutProperties {
        var properties = LayoutProperties()
        properties.stackOrientation = .vertical
        return properties
    }

}