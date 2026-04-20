//
//  Palette Grid.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI

struct PaletteBox: View {
    var body: some View {
        VStack {
            HStack {
                Swatch(color: .green)
                Swatch(color: .yellow)
                Swatch(color: .orange)
                Swatch(color: .red)
                Swatch(color: .pink)
                Swatch(color: .purple)
            }
            .frame(height: 20)
            HStack {
                Swatch(color: .blue)
                Swatch(color: .cyan)
                Swatch(color: .teal)
                Swatch(color: .mint)
                Swatch(color: .white)
                Swatch(color: .black)
            }
            .frame(height: 20)
        }
        .labelsHidden()
    }
}
