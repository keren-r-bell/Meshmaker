//
//  ColorInputField.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 22/4/26.
//

import SwiftUI

struct ColorInputField: View {
    @State var isHovering: Bool = false
    @Binding var color: Color
    
    var body: some View {
        VStack {
            TextField("Hex", text: .constant(color.description))
                .textFieldStyle(.roundedBorder)
                .fontDesign(.monospaced)
                .overlay(alignment: .trailing) {
                    if isHovering {
                        Button("Copy color", systemImage: "document.on.document") {
                            #if canImport(AppKit)
                                NSPasteboard.general.clearContents()
                                NSPasteboard.general.setString(color.description, forType: .string)
                            #elseif canImport(UIKit)
                                UIPasteboard.general.string = color.description//hsbaString(for: color)
                            #endif
                        }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.glassProminent)
                    }
                }
                .lineLimit(1)
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
