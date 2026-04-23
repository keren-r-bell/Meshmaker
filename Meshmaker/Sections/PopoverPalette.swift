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
            ColorInputField(color: $color)
            
            SimilarColors(color: $color)
        }
        .padding(8)
        .frame(width: 140, height: 100)
    }
}
