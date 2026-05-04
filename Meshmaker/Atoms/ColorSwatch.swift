//
//  Color Swatch.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI

struct Swatch: View {
    var color: Color
    var stroke: Color = .white
    var radii: CGFloat = 4
    
    var body: some View {
        RoundedRectangle(cornerRadius: radii)
            .fill(color)
            .stroke(stroke, lineWidth: 2)
            .draggable(color) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: 32, height: 24)
            }
    }
}

#Preview {
    VStack {
        ColorPicker("Color", selection: .constant(.green))
        HStack {
            Swatch(color: .orange)
            Swatch(color: .red)
            Swatch(color: .purple)
            Swatch(color: .blue)
        }
        .frame(width: 200, height: 40)
    }
    .environmentObject(CanvasState())
}
