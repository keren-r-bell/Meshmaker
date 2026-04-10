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
    
    var body: some View {
        HStack {
            Text(name)
            
            Button {
                print("Penis")
            } label: {
                Text(hsbaString(for: color))
                    .foregroundStyle(.secondary)
                    .fontWidth(.compressed)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .buttonStyle(.plain)
            
            ColorPicker("Color", selection: $color).labelsHidden()
        }
        .lineLimit(1)
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
