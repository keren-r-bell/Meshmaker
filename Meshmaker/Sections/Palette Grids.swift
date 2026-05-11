//
//  Palette Grid.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI
import TipKit

extension Notification.Name {
    static let similarColorWillApply = Notification.Name("SimilarColorWillApply")
}

struct PaletteBox: View {
    @EnvironmentObject var canvasState: CanvasState
    
    var colors: [Color] = [.green, .yellow, .orange, .red, .pink, .purple, .blue, .cyan, .teal, .mint, .white, .black]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<colors.count) { index in
                Swatch(color: colors[index], radii: 2).onTapGesture { canvasState.applyColorToSelection (colors[index]) }
            }
        }
        .frame(height: 24)
    }
}

struct ReceiverSwatch: View {
    @EnvironmentObject var canvasState: CanvasState
    
    @Binding var color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(color)
            .padding(4)
            .background { RoundedRectangle(cornerRadius: 12).fill(.white) }
            .shadow(radius: 2, y: 1)
        
            .dropDestination(for: Color.self) { colors, _ in
                guard let newColor = colors.first else { return false }
                canvasState.markUndoPoint("Change Color")
                color = newColor
                return true
            }
            .draggable(color) {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(color)
                    .frame(width: 32, height: 24)
            }
        //todo: voiceover palette descs!
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
                    .clipShape(.rect(cornerRadius: 2))
                SimilarSwatch(affectedColor: $color, color: briDown)
                    .clipShape(.rect(cornerRadius: 2))
            }
            /*
            RoundedRectangle(cornerRadius: 2)
                .fill(color)
                .padding(.horizontal, 2)
                .draggable(color) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(color)
                        .frame(width: 32, height: 24)
                }
            */
            VStack(spacing: 2) {
                let satUp = Color(hue: hue, saturation: min(sat + 0.18, 1.0), brightness: bri)
                let satDown = Color(hue: hue, saturation: max(sat - 0.18, 0.0), brightness: bri)
                SimilarSwatch(affectedColor: $color, color: satUp)
                    .clipShape(.rect(cornerRadius: 2))
                SimilarSwatch(affectedColor: $color, color: satDown)
                    .clipShape(.rect(cornerRadius: 2))
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
                .onTapGesture {
                    // Attempt to find a CanvasState in the environment via the responder chain
                    // Since SimilarColors is used inside the inspector that has access to the canvas state,
                    // we can broadcast a notification or use an explicit environment object if available.
                    // To keep this localized, post a notification that CanvasState can observe (simple and native).
                    NotificationCenter.default.post(name: .similarColorWillApply, object: nil)
                    affectedColor = color
                    ColorPaletteTutorialTip.pressedColorsBefore = true
                }
                .draggable(color) {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(color)
                        .frame(width: 32, height: 24)
                }
        }
    }
}

public func hsbaComponents(of color: Color) -> (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
    let native = NSColor(color).usingColorSpace(.deviceRGB) ?? .black
    var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    native.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    
    return (h, s, b, a)
}
