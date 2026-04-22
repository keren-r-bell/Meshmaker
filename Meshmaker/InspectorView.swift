// InspectorView.swift
import SwiftUI

struct InspectorView: View {
    // Inject the environment object
    @EnvironmentObject var canvasState: CanvasState
    
    var body: some View {
        VStack(alignment: .leading) {
            CodeExportBox()
            Divider()
            PaletteBox()
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                ScrollView {
                    ForEach(Array(canvasState.points.enumerated()), id: \.offset) { rowIndex, row in
                        ForEach(Array(row.enumerated()), id: \.offset) { colIndex, _ in
                            let point = canvasState.points[rowIndex][colIndex]
                            
                            if canvasState.selectedPointIDs.contains(point.id) {
                                SelectedColorRow(name: "(\(rowIndex+1), \(colIndex+1))", color: $canvasState.points[rowIndex][colIndex].color)
                            }
                        }
                    }
                    if canvasState.selectedPointIDs.isEmpty {
                        //SelectedColorRow(name: "No color selected", color: .constant(.gray))
                        ///Maybe put the "Make new gradient" setup here?
                    }
                }
                .safeAreaPadding(.vertical, 8)
                Divider()
            }
            Toggle("Smooth Gradients", systemImage: "graph.2d", isOn: $canvasState.smoothGrads)
        }
        .safeAreaPadding()
    }
}
