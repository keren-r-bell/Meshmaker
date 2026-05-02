//
//  UndoRedoButtons.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 2/5/26.
//

import SwiftUI

struct UndoButton: View {
    @EnvironmentObject var canvasState: CanvasState

    var body: some View {
        Button("Undo \(canvasState.undoManager?.undoActionName ?? "")", systemImage: "arrow.uturn.backward") {
            canvasState.undo()
        }.disabled(canvasState.undoManager?.canUndo ?? false == false)
    }
}


struct RedoButton: View {
    @EnvironmentObject var canvasState: CanvasState

    var body: some View {
        Button("Redo \(canvasState.undoManager?.redoActionName ?? "")", systemImage: "arrow.uturn.forward") {
            canvasState.redo()
        }.disabled(canvasState.undoManager?.canRedo ?? false == false)
    }
}
