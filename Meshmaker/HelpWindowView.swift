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
            VStack(alignment: .leading, spacing: 6) {
                Text("Meshmaker Help")
                    .font(.largeTitle)
                Text("**Meshmaker** lets you create Mesh Gradient elements for your SwiftUI code in an easily, precise canvas.")
                Text("This app was made because of how frustrating I found coding even simple placeholder visuals using the very visually pleasing MeshGradient structure, so I figured someone should make a tool for it, and despite some options existing online, I still felt compelled to make my own.\nBut, enough personal stories.")
                Divider()
                Text("Starting Off")
                    .font(.title2).bold().padding(.vertical, 4)
                Text("The program opens with a classic preset. You can get familiar with using Meshmaker by toying with the additional presets, using the **\(Image(systemName: "plus.square.dashed"))** button on the top-right.")
                Text("The point of the program is to use your design in SwiftUI apps. Once you have a design you like, press **\(Image(systemName: "document.on.document")) Copy to Clipboard**, and test it in your app.")
                Divider()
                Text("Moving Points")
                    .font(.title2).bold().padding(.vertical, 4)
                Text("Drag the control **\(Image(systemName: "largecircle.fill.circle")) points** to move them, affecting the flow of colors. If you exceed the square canvas, points will snap back to place.")
                Text("You can use **\(Image(systemName: "shift")) Shift** to select multiple points, and move them together.")
                Divider()
                Text("Coloring Points")
                    .font(.title2).bold().padding(.vertical, 4)
                Text("When you select any amount of points, pressing a **\(Image(systemName: "swatchpalette.fill")) Swatch** will color all of them. You can [well, to be implemented, but you will be able to] drag colors from swatch onto specific points, and colors from points to a new swatch spot. Right click a swatch in the sidebar to delete it. [To be implemented!]")
                Divider()
                Text("Adding Points")
                    .font(.title2).bold().padding(.vertical, 4)
                Text("When you add a point to the canvas, additional points are needed to maintain symmetry of width/height.")
                Text("As you hover across the canvas, a line demonstrates along which axis the additional points will be spread. As you hold to place the point, you can see where exactly the other points will be placed.")
                Text("You can hold **\(Image(systemName: "shift")) Shift** to lock the line in place for more precise control.\nYou can hold **\(Image(systemName: "option")) Option** to invert the line’s automatic direction.")
            }
        }
        .safeAreaPadding(32)
    }
}

#Preview {
    HelpWindowView()
}
