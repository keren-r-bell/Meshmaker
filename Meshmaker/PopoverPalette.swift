//
//  PopoverPalette.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI

struct PopoverPalette: View {
    @Binding var color: Color
    
    var hueBinding: Binding<Double> {
        Binding(
            get: { Double(hsbaComponents(of: color).h) },
            set: { newH in
                let c = hsbaComponents(of: color)
                color = Color(hue: newH, saturation: c.s, brightness: c.b, opacity: c.a)
            }
        )
    }
    var satBinding: Binding<Double> {
        Binding(
            get: { Double(hsbaComponents(of: color).s) },
            set: { newS in
                let c = hsbaComponents(of: color)
                color = Color(hue: c.h, saturation: newS, brightness: c.b, opacity: c.a)
            }
        )
    }

    var briBinding: Binding<Double> {
        Binding(
            get: { Double(hsbaComponents(of: color).b) },
            set: { newB in
                let c = hsbaComponents(of: color)
                color = Color(hue: c.h, saturation: c.s, brightness: newB, opacity: c.a)
            }
        )
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 2) {
                Swatch(color: .green    ).onTapGesture { color = .green  }
                Swatch(color: .yellow   ).onTapGesture { color = .yellow }
                Swatch(color: .orange    ).onTapGesture { color = .orange }
                Swatch(color: .red    ).onTapGesture { color = .red    }
                Swatch(color: .purple    ).onTapGesture { color = .purple }
                Swatch(color: .blue    ).onTapGesture { color = .blue   }
            }
            .frame(height: 16)
            
            TextField("Hex", text: .constant(color.description))
                .textFieldStyle(.roundedBorder)
            //.frame(minWidth: 80, maxWidth: 160)
            
            SpecialSlider(value: hueBinding, colors: [
                Color(hue: 0.00, saturation: satBinding.wrappedValue, brightness: briBinding.wrappedValue),
                Color(hue: 0.16, saturation: satBinding.wrappedValue, brightness: briBinding.wrappedValue),
                Color(hue: 0.33, saturation: satBinding.wrappedValue, brightness: briBinding.wrappedValue),
                Color(hue: 0.50, saturation: satBinding.wrappedValue, brightness: briBinding.wrappedValue),
                Color(hue: 0.66, saturation: satBinding.wrappedValue, brightness: briBinding.wrappedValue),
                Color(hue: 0.73, saturation: satBinding.wrappedValue, brightness: briBinding.wrappedValue),
                Color(hue: 1.00, saturation: satBinding.wrappedValue, brightness: briBinding.wrappedValue)
            ])
            SpecialSlider(value: satBinding, colors: [
                          Color(hue: hueBinding.wrappedValue, saturation: 0, brightness: briBinding.wrappedValue),
                          Color(hue: hueBinding.wrappedValue, saturation: 1, brightness: briBinding.wrappedValue)
            ])
            SpecialSlider(value: briBinding, colors: [
                          Color(hue: hueBinding.wrappedValue, saturation: satBinding.wrappedValue, brightness: 0),
                          Color(hue: hueBinding.wrappedValue, saturation: satBinding.wrappedValue, brightness: 1)
            ])
        }
        .padding()
        .presentationDetents([.height(80)])
        .frame(width: 150)
    }
}

func hsbaComponents(of color: Color) -> (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
    #if canImport(AppKit)
    let native = NSColor(color).usingColorSpace(.deviceRGB) ?? .black
    var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    native.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    return (h, s, b, a)
    #endif
}
