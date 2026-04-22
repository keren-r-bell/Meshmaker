//
//  SpecialSlider.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 20/4/26.
//


import SwiftUI

///Currently unused, as the app doesn't use HSB sliders after all. But it's a cool idea!
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

///The setup for bounded HSB variables
/*
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
 */
///And the slider setup
/*
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
 */
