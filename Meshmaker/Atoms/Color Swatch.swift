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
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(color)
            //.fill(.shadow(.inner(color: .black.opacity(0.3), radius: 3, y: 1)))
            .stroke(.white, lineWidth: 2)
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
                Circle()
                    .fill(color)
                    .frame(width: 16, height: 16)
                    .padding(4)
            }
            .onTapGesture {
                canvasState.applyColorToSelection(color)
            }
    }
}
