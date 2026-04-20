//
//  SelectedColorRow.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI
import AppKit

struct SelectedColorRow: View {
    var name: String = "Color"
    @Binding var color: Color
    @State var showCopyButton: Bool = false
    
    var body: some View {
        HStack {
            Text(name)
            
            Button {
                print("BLuhhh")
            } label: {
                Text(color.description)
                    .foregroundStyle(.secondary)
                    .fontWidth(.compressed)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .buttonStyle(.plain)
            .overlay(alignment: .trailing) {
                if showCopyButton {
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
            
            ColorPicker("Color", selection: $color).labelsHidden()
        }
        .lineLimit(1)
        .contentShape(.containerRelative)
        .onContinuousHover { phase in
            switch phase {
            case .active(let _):
                showCopyButton = true
            case .ended:
                showCopyButton = false
            }
        }
    }
}

#Preview {
    @Previewable @State var colors: [Color] = [.indigo, .blue, .cyan, .mint, .green]
    var color: Color = .red
    
    VStack {
        SelectedColorRow(color: $colors[0])
        SelectedColorRow(color: $colors[1])
        SelectedColorRow(color: $colors[2])
        SelectedColorRow(color: $colors[3])
        SelectedColorRow(color: $colors[4])
    }
}
