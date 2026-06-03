//
//  CodeExportBox.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI
import AppKit
typealias NativeColor = NSColor

// Global helper to copy the current mesh code from a given canvas state.
  func copyMeshCode(from canvasState: CanvasState) {
      let generatedCode = generateMeshGradientCode(
          width: canvasState.meshWidth,
          height: canvasState.meshHeight,
          points: canvasState.points,
          smoothGrads: canvasState.smoothGrads
      )
      NSPasteboard.general.clearContents()
      NSPasteboard.general.setString(generatedCode, forType: .string)
  }

struct CodeExportBox: View {
    @EnvironmentObject var canvasState: CanvasState
    
    // 1. Add a computed property to generate the code based on the current state
    private var generatedCode: String {
        generateMeshGradientCode(
            width: canvasState.meshWidth,
            height: canvasState.meshHeight,
            points: canvasState.points,
            smoothGrads: canvasState.smoothGrads
        )
    }
    
    var body: some View {
        GroupBox {
            TextEditor(text: .constant(generatedCode))
                .font(.system(size: 8, design: .monospaced))
                .scrollContentBackground(.hidden)
                .frame(height: 130)
                .disabled(true)
                .focusable(false)
        } label: {
            Label("SwiftUI Code", systemImage: "swift")
        }
        .overlay(alignment: .bottomTrailing) {
            Button("Copy to Clipboard", systemImage: "doc.on.doc") {
                copyMeshCode(from: canvasState)
            }
            .buttonStyle(.glassProminent) // Assuming this is your custom style
            .padding()
        }
    }
}
    
func generateMeshGradientCode(width: Int, height: Int, points: [[MeshPoint]], smoothGrads: Bool) -> String {
    var pointsRows = [String]()
    var colorsRows = [String]()
    
    for rowPoints in points {
        // 1. Format positions: [x, y]
        let pointsString = rowPoints.map { point in
            let xStr = String(format: "%g", point.x)
            let yStr = String(format: "%g", point.y)
            return "[\(xStr), \(yStr)]"
        }.joined(separator: ", ")
        
        // 2. Format colors
        let colorsString = rowPoints.map { point in
            return hsbaString(for: point.color)
        }.joined(separator: ", ")
        
        // Indent the rows for pretty printing
        pointsRows.append("        " + pointsString)
        colorsRows.append("        " + colorsString)
    }
    
    let allPoints = pointsRows.joined(separator: ",\n")
    let allColors = colorsRows.joined(separator: ",\n")
    
    // 3. Construct the final string template
    return """
        MeshGradient(
            width: \(width),
            height: \(height),
            points: [
        \(allPoints)
            ],
            colors: [
        \(allColors)
            ],
            smoothsColors: \(smoothGrads)
        )
        """
}


func hsbaString(for color: Color) -> String {
    let description = String(describing: color)
    if !description.contains("Color") && !description.contains("#") && !description.contains(" ") {
        return ".\(description)"
    }
    
    let native = NSColor(color)
    var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    if let rgb = native.usingColorSpace(.deviceRGB) {
        rgb.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        let base = String(format: "Color(hue: %.2f, saturation: %.2f, brightness: %.2f)", h, s, b)
        return a < 1.0 ? base + ".opacity(\(String(format: "%.2f", a)))" : base
    }
    return ".clear"
}

