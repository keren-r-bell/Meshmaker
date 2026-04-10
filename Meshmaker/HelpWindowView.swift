//
//  HelpWindowView.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 7/4/26.
//

import SwiftUI

struct HelpWindowView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Meshmaker Help")
                    .font(.largeTitle)
                Divider()
                Text("Moving and Modifying Points")
                    .font(.title2)
                Text("**Click** a \(Image(systemName: "largecircle.fill.circle")) Point to open a palette. You can use \(Image(systemName: "shift")) Shift to select, move and modify multiple points at once.")
                Text("When you click a \(Image(systemName: "swatchpalette.fill")) Swatch, **all selected points** will change to its color.")
                Text("**Drag** points to move them around. If you try to move a point past the canvas, it will spring back inbounds.")
            }
        }
        .safeAreaPadding(32)
    }
}

#Preview {
    HelpWindowView()
}
