//
//  Mesh Presets.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI
import TipKit

struct PresetMenu: View {
    @EnvironmentObject var canvasState: CanvasState
    
    var body: some View {
        Menu("New...", systemImage: "plus") {
            Button("New", systemImage: "square.dotted") {
                NewPaletteTutorial.usedInitialBefore = true
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 2
                    canvasState.meshHeight = 2
                    canvasState.points = preset0
                    canvasState.selectedPointIDs = []
                }
            }.keyboardShortcut("1", modifiers: .control.union(.shift))
            
            Button("Default", systemImage: "squareshape.split.2x2.dotted.inside.and.outside") {
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 3
                    canvasState.meshHeight = 3
                    canvasState.points = preset1
                    canvasState.selectedPointIDs = []
                }
            }.keyboardShortcut("2", modifiers: .control.union(.shift))
            
            Button("kule laso", systemImage: "humidity") {
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 4
                    canvasState.meshHeight = 4
                    canvasState.points = preset2
                    canvasState.selectedPointIDs = []
                }
            }.keyboardShortcut("3", modifiers: .control.union(.shift))
            
            Button("Flame", systemImage: "flame") {
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 3
                    canvasState.meshHeight = 4
                    canvasState.points = preset3
                    canvasState.selectedPointIDs = []
                }
            }.keyboardShortcut("4", modifiers: .control.union(.shift))
            
            Button("Iconic", systemImage: "app.gift.fill") {
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 3
                    canvasState.meshHeight = 3
                    canvasState.points = preset4
                    canvasState.selectedPointIDs = []
                }
            }.keyboardShortcut("5", modifiers: .control.union(.shift))
            
            Button("Complex", systemImage: "graph.2d") {
                withAnimation(.bouncy) {
                    canvasState.meshWidth = 10
                    canvasState.meshHeight = 10
                    canvasState.points = preset5
                    canvasState.selectedPointIDs = []
                }
            }.keyboardShortcut("6", modifiers: .control.union(.shift))
        }
    }
}
