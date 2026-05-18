// InspectorView.swift
import SwiftUI

struct InspectorView: View {
    @EnvironmentObject var canvasState: CanvasState
    
    var body: some View {
        VStack(alignment: .leading) {
            CodeExportBox()
            Divider()
            if canvasState.selectedPointIDs.isEmpty && canvasState.meshWidth < 3 && canvasState.meshHeight < 3 {
                NewMeshSetup()
            } else {
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
                    }
                    .safeAreaPadding(.vertical, 8)
                    Divider()
                }
            }
            Toggle("Smooth Gradients", isOn: $canvasState.smoothGrads)
        }
        .safeAreaPadding()
    }
}
