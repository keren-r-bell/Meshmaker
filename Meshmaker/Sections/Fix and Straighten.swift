//
//  Fix and Straighten.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 28/4/26.
//

import SwiftUI

struct FixFrameButton: View {
    @EnvironmentObject var canvasState: CanvasState
    
    var body: some View {
        Button(
            canvasState.isOptionDown ? canvasState.isShiftDown ? "Straighten All Points" : "Straighten Frame" : "Fit frame",
            systemImage: canvasState.isOptionDown ? canvasState.isShiftDown ? "squareshape.split.3x3" : "squareshape.dotted.squareshape" : "squareshape"
        ) {
            withAnimation(.snappy) {
                if canvasState.isOptionDown {
                    if canvasState.isShiftDown {
                        canvasState.straightenMesh()
                    } else {
                        canvasState.straightenFrame()
                    }
                } else {
                    canvasState.fixFrame()
                }
            }
        }
    }
}
