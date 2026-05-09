//
//  ArrowNudges.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 9/5/26.
//

import SwiftUI
//this is embarassing i think!

struct NudgeShortcutButtons: View {
    @EnvironmentObject var canvasState: CanvasState
    let stip = 0.03
    let step = 0.15
    
    var body: some View {
        Button("Move Up") {
            canvasState.moveSelectedPoints(by: CGSizeMake(0, -(canvasState.isShiftDown ? step : stip)), isFinalizing: true)
        }
        .keyboardShortcut(.upArrow, modifiers: [])
        .frame(width: 0, height: 0).opacity(0).accessibilityHidden(true)
        
        Button("Move Down") {
            canvasState.moveSelectedPoints(by: CGSizeMake(0, canvasState.isShiftDown ? step : stip), isFinalizing: true)
        }
        .keyboardShortcut(.downArrow, modifiers: [])
        .frame(width: 0, height: 0).opacity(0).accessibilityHidden(true)
        
        Button("Move Left") {
            canvasState.moveSelectedPoints(by: CGSizeMake(-(canvasState.isShiftDown ? step : stip), 0), isFinalizing: true)
        }
        .keyboardShortcut(.leftArrow, modifiers: [])
        .frame(width: 0, height: 0).opacity(0).accessibilityHidden(true)
        
        Button("Move Right") {
            canvasState.moveSelectedPoints(by: CGSizeMake(canvasState.isShiftDown ? step : stip, 0), isFinalizing: true)
        }
        .keyboardShortcut(.rightArrow, modifiers: [])
        .frame(width: 0, height: 0).opacity(0).accessibilityHidden(true)
    }
}
