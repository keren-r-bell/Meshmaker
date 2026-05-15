//
//  HelpDocViews.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 15/5/26.
//

import SwiftUI

struct HelpPaletteView: View {
    @State var color: Color = .pink
    
    var body: some View {
        VStack(spacing: 3) {
            HStack {
                Spacer()
                Image(systemName: "slider.horizontal.below.sun.max")
                Image(systemName: "circle.lefthalf.striped.horizontal")
                    .padding(.trailing, 20)
            }
            
            HStack {
                //careful reimplementation of ReceiverSwatch for this context
                Circle()
                    .fill(color)
                    .stroke(.white, lineWidth: 6)
                    .padding(4)
                    .shadow(radius: 2, y: 1)
                
                    .dropDestination(for: Color.self) { colors, _ in
                        guard let newColor = colors.first else { return false }
                        color = newColor
                        return true
                    }
                    .draggable(color) {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(color)
                            .frame(width: 32, height: 24)
                    }
                    .frame(width: 48, height: 48)
                    .padding(.leading)
                Spacer().frame(width: 40)
                
                Image(systemName: "paintpalette")
                SimilarColors(color: $color)
                    .frame(width: 100, height: 48)
                Image(systemName: "paintpalette.fill")
            }
            
            HStack {
                Spacer()
                Image(systemName: "sun.min")
                Image(systemName: "circle.lefthalf.filled.righthalf.striped.horizontal")
                    .padding(.trailing, 20)
            }
        }
        .frame(width: 180)
        .padding()
    }
}
