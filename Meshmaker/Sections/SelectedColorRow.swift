//
//  SelectedColorRow.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI

struct SelectedColorRow: View {
    var name: String = "Color"
    @Binding var color: Color
    @State var showCopyButton: Bool = false
    
    var body: some View {
        HStack {
            SimilarColors(color: $color)
            
            VStack(alignment: .leading) {
                Text(name)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                
                ColorInputField(color: $color)
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
