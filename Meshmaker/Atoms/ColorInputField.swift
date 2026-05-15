//
//  ColorInputField.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 22/4/26.
//

import SwiftUI
import AppKit

struct ColorInputField: View {
    @State var isHovering: Bool = false
    @Binding var color: Color
    
    var body: some View {
        VStack {
            TextField("Hex", text: .constant(hsbaString(for: color)))
                .textFieldStyle(.roundedBorder)
                .fontDesign(.monospaced)
                .overlay(alignment: .trailing) {
                    if isHovering {
                        Button("Copy color", systemImage: "document.on.document") {
                            NSPasteboard.general.clearContents()
                            NSPasteboard.general.setString(hsbaString(for: color), forType: .string)
                        }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.glassProminent)
                    }
                }
                .lineLimit(1)
                .focusable(false)
                .contentShape(.containerRelative)
                .onContinuousHover { phase in
                    switch phase {
                    case .active:
                        isHovering = true
                    case .ended:
                        isHovering = false
                    }
                }
        }
    }
}
