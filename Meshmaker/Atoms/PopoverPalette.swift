//
//  PopoverPalette.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI

struct PopoverPalette: View {
    @Binding var color: Color
    
    var body: some View {
        VStack {
            TextField("Hex", text: .constant(color.description))
                .textFieldStyle(.roundedBorder)
                .frame(minWidth: 80, maxWidth: 160)
            HStack(spacing: 2) {
                Swatch(color: .green    ).onTapGesture { color = .green  }
                Swatch(color: .yellow   ).onTapGesture { color = .yellow }
                Swatch(color: .orange    ).onTapGesture { color = .orange }
                Swatch(color: .red    ).onTapGesture { color = .red    }
                Swatch(color: .purple    ).onTapGesture { color = .purple }
                Swatch(color: .blue    ).onTapGesture { color = .blue   }
            }
            .frame(height: 16)
            ColorPicker("Color", selection: $color)
        }
        .padding()
        .presentationDetents([.height(80)])
    }
}
