//
//  SpecialSlider.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 20/4/26.
//

import SwiftUI

struct SpecialSlider: View {
    @Binding var value: Double
    var colors: [Color] = [.red, .blue]
    
    var body: some View {
        Slider(value: $value, in: 0...1)
            .overlay {
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing))
                        .stroke(.white, lineWidth: 2)
                        .zIndex(9)
                    Point(color: (colors.first ?? .gray).mix(with: colors.last ?? .gray, by: value))
                        .zIndex(10)
                        .offset(x: 100 * value)
                        .pointerStyle(.grabIdle)
                }
                .allowsHitTesting(false)
            }
    }
}
