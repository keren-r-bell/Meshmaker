//
//  Mesh Presets.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI

struct PresetMenu: View {
    @EnvironmentObject var canvasState: CanvasState
    
    var body: some View {
        Menu("New...", systemImage: "plus.square.dashed") {
            // When creating a new state, we need to update the meshWidth and meshHeight as well.
            // This implies CanvasState needs a method to reset its points and dimensions.
            // For now, direct manipulation for demonstration.
            Button("Default", systemImage: "squareshape.split.2x2.dotted.inside.and.outside") {
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 3
                    canvasState.meshHeight = 3
                    // Assuming preset0 is accessible and correctly defined.
                    canvasState.points = preset0
                }// Animation for state change
            }.keyboardShortcut("1", modifiers: .control.union(.shift))
            
            Button("Empty", systemImage: "square.dotted") {
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 2
                    canvasState.meshHeight = 2
                    canvasState.points = preset1
                }
            }.keyboardShortcut("2", modifiers: .control.union(.shift))
            
            Button("kule laso", systemImage: "humidity") {
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 4
                    canvasState.meshHeight = 4
                    canvasState.points = preset2
                }
            }.keyboardShortcut("3", modifiers: .control.union(.shift))
            
            Button("Flame", systemImage: "flame") {
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 3
                    canvasState.meshHeight = 4
                    canvasState.points = preset3
                }
            }.keyboardShortcut("4", modifiers: .control.union(.shift))
            
            Button("Iconique", systemImage: "app.gift.fill") {
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 2
                    canvasState.meshHeight = 2
                    canvasState.points = preset4
                }
            }.keyboardShortcut("5", modifiers: .control.union(.shift))
            
            Button("Complex", systemImage: "graph.2d") {
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 10
                    canvasState.meshHeight = 10
                    canvasState.points = preset5
                }
            }.keyboardShortcut("6", modifiers: .control.union(.shift))
        }
    }
}
