//
//  Color Swatch.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI

struct Swatch: View {
    @EnvironmentObject var canvasState: CanvasState
    var color: Color
    var stroke: Color = .white
    var radii: CGFloat = 4
    
    var body: some View {
        RoundedRectangle(cornerRadius: radii)
            .fill(color)
            .stroke(stroke, lineWidth: 2)
            .draggable(color) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 32, height: 24)
                    .foregroundStyle(color.gradient)
            }
    }
}
