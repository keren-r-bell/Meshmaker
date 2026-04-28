//
//  Palette Grid.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI
import TipKit

struct PaletteBox: View {
    @EnvironmentObject var canvasState: CanvasState
    
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 6) {
                Swatch(color: .green).onTapGesture { canvasState.applyColorToSelection(.green) }
                Swatch(color: .yellow).onTapGesture { canvasState.applyColorToSelection(.yellow) }
                Swatch(color: .orange).onTapGesture { canvasState.applyColorToSelection(.orange) }
                Swatch(color: .red).onTapGesture { canvasState.applyColorToSelection(.red) }
                Swatch(color: .pink).onTapGesture { canvasState.applyColorToSelection(.pink) }
                Swatch(color: .purple).onTapGesture { canvasState.applyColorToSelection(.purple) }
            }
            .frame(height: 24)
            HStack(spacing: 6) {
                Swatch(color: .blue).onTapGesture { canvasState.applyColorToSelection(.blue) }
                Swatch(color: .cyan).onTapGesture { canvasState.applyColorToSelection(.cyan) }
                Swatch(color: .teal).onTapGesture { canvasState.applyColorToSelection(.teal) }
                Swatch(color: .mint).onTapGesture { canvasState.applyColorToSelection(.mint) }
                Swatch(color: .white).onTapGesture { canvasState.applyColorToSelection(.white) }
                Swatch(color: .black).onTapGesture { canvasState.applyColorToSelection(.black) }
            }
            .frame(height: 24)
        }
        .labelsHidden()
    }
}

struct SimilarColors: View {
    @Binding var color: Color
    
    var hue: CGFloat { hsbaComponents(of: color).h }
    var sat: CGFloat { hsbaComponents(of: color).s }
    var bri: CGFloat { hsbaComponents(of: color).b }
    
    var body: some View {
        HStack(spacing: 2) {
            let hueLeft = Color(hue: hue - 0.05, saturation: sat, brightness: bri)
            SimilarSwatch(affectedColor: $color, color: hueLeft)
                .clipShape(.rect(topLeadingCorner: 8, topTrailingCorner: 2, bottomLeadingCorner: 8, bottomTrailingCorner: 2))
            
            VStack(spacing: 2) {
                let briUp =   Color(hue: hue, saturation: sat, brightness: min(bri + 0.14, 1.0))
                let briDown = Color(hue: hue, saturation: sat, brightness: max(bri - 0.14, 0.0))
                
                SimilarSwatch(affectedColor: $color, color: briUp)
                SimilarSwatch(affectedColor: $color, color: briDown)
            }
            
            RoundedRectangle(cornerRadius: 2)
                .fill(color)
                .padding(.horizontal, 2)
            
            VStack(spacing: 2) {
                let satUp = Color(hue: hue, saturation: min(sat + 0.18, 1.0), brightness: bri)
                let satDown = Color(hue: hue, saturation: max(sat - 0.18, 0.0), brightness: bri)
                SimilarSwatch(affectedColor: $color, color: satUp)
                SimilarSwatch(affectedColor: $color, color: satDown)
            }
            
            let overHue = hue + 0.05 //Small fix to wrap color around
            let hueRight = Color(hue: overHue > 1.0 ? overHue - 1.0 : overHue, saturation: sat, brightness: bri)
            SimilarSwatch(affectedColor: $color, color: hueRight)
                .clipShape(.rect(topLeadingCorner: 2, topTrailingCorner: 8, bottomLeadingCorner: 2, bottomTrailingCorner: 8))
        }
        .padding(4)
        .background { RoundedRectangle(cornerRadius: 12).fill(.white) }
        .shadow(radius: 2, y: 1)
    }
    
    private struct SimilarSwatch: View {
        @Binding var affectedColor: Color
        var color: Color = .blue
        
        var body: some View {
            Rectangle()
                .fill(color)
                .onTapGesture { affectedColor = color; ColorPaletteTutorialTip.pressedColorsBefore = true }
        }
    }
}

public func hsbaComponents(of color: Color) -> (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
    #if canImport(AppKit)
        let native = NSColor(color).usingColorSpace(.deviceRGB) ?? .black
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        native.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        
        return (h, s, b, a)
    #endif
}
