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
            canvasState.isOptionDown ? canvasState.isShiftDown ? "Straighten All Points" : "Straighten Frame" : "Fit Frame",
            systemImage: canvasState.isOptionDown ? canvasState.isShiftDown ? "squareshape.split.3x3" : "squareshape.split.2x2.dotted.inside" : "squareshape.dotted.squareshape"
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
        //.contentTransition(.symbolEffect(.replace.downUp))
        /*
        Button("Fit Frame", systemImage: "squareshape.dotted.squareshape") { canvasState.fixFrame() }
            .modifierKeyAlternate(.option) {
                Button("Straighten Frame", systemImage: "squareshape.split.2x2.dotted.inside") { canvasState.straightenFrame() }
            }
            .modifierKeyAlternate(.option.union(.shift)) {
                Button("Straighten Mesh", systemImage: "squareshape.split.3x3") { canvasState.straightenMesh() }
            }
         */ /// Maybe this works? Doesn't seem like it does.
    }
}
