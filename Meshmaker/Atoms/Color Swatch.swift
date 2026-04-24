//
//  Color Swatch.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI
import AppKit

struct Swatch: View {
    @EnvironmentObject var canvasState: CanvasState
    var color: Color
    var stroke: Color = .white
    var radii: CGFloat = 4
    
    var body: some View {
        RoundedRectangle(cornerRadius: radii)
            .fill(color)
            //.stroke(.shadow(.inner(color: .black.opacity(0.07), radius: 3, y: 1)))
            .stroke(stroke, lineWidth: 2)
            .onDrag {
                // Provide native color pasteboard data so ColorPicker/NSColorWell can accept the drop
                let nsColor = NSColor(color)
                let provider = NSItemProvider()
                if let data = try? NSKeyedArchiver.archivedData(withRootObject: nsColor, requiringSecureCoding: false) {
                    provider.registerDataRepresentation(forTypeIdentifier: NSPasteboard.PasteboardType.color.rawValue, visibility: .all) { completion in
                        completion(data, nil)
                        return nil
                    }
                }
                return provider
            } preview: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: 32, height: 32)
            }
    }
}
