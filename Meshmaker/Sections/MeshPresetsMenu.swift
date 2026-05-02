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
                    canvasState.applyTemplate(preset0, actionName: "Create New Mesh")
                }
            }.keyboardShortcut("1", modifiers: .control.union(.shift))
            
            Button("Default", systemImage: "squareshape.split.2x2.dotted.inside.and.outside") {
                withAnimation(.bouncy) {
                    canvasState.applyTemplate(preset1, actionName: "Use Default Preset")
                }
            }.keyboardShortcut("2", modifiers: .control.union(.shift))
            
            Button("kule laso", systemImage: "humidity") {
                withAnimation(.bouncy) {
                    canvasState.applyTemplate(preset2, actionName: "Use kule laso Preset")
                }
            }.keyboardShortcut("3", modifiers: .control.union(.shift))
            
            Button("Flame", systemImage: "flame") {
                withAnimation(.bouncy) {
                    canvasState.applyTemplate(preset3, actionName: "Use Flame Preset")
                }
            }.keyboardShortcut("4", modifiers: .control.union(.shift))
            
            Button("Iconic", systemImage: "app.gift.fill") {
                withAnimation(.bouncy) {
                    canvasState.applyTemplate(preset4, actionName: "Use Iconic Preset")
                }
            }.keyboardShortcut("5", modifiers: .control.union(.shift))
            
            Button("Complex", systemImage: "graph.2d") {
                withAnimation(.bouncy) {
                    canvasState.applyTemplate(preset5, actionName: "Use Complex Preset")
                }
            }.keyboardShortcut("6", modifiers: .control.union(.shift))
        }
    }
}
