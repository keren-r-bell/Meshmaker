//
//  MyDockTileView.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 8/5/26.
//

import SwiftUI

struct MyDockTileView: View {
    @EnvironmentObject var canvasState: CanvasState
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16).fill(.background)
            
            MeshGradient(
                width: canvasState.meshWidth,
                height: canvasState.meshHeight,
                points: canvasState.points.flatMap { row in
                    row.map { SIMD2($0.x, $0.y) }
                },
                colors: canvasState.points.flatMap { row in
                    row.map { $0.color }
                },
                smoothsColors: canvasState.smoothGrads
            )
            .cornerRadius(16)
            
            RoundedRectangle(cornerRadius: 16).stroke(.white, lineWidth: 4)
        }
        .padding()
        .background(.ultraThinMaterial.opacity(0.6))
        .cornerRadius(32)
    }
}
