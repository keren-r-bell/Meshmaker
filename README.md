# Meshmaker  
  
**Meshmaker** lets you create Mesh Gradient elements for your SwiftUI code in an easily, precise canvas.  
  
This app was made because of how frustrating I found coding even simple placeholder visuals using the very visually pleasing [MeshGradient](https://developer.apple.com/documentation/SwiftUI/MeshGradient) structure, so I figured someone should make a tool for it, and despite some options existing online, I still felt compelled to make my own. But, enough personal stories.  
  
### Starting Off  
The program opens with a classic preset. You can get familiar with using Meshmaker by toying with the additional presets, using the **⊞** button on the top-right.  
The point of the program is to use your design in SwiftUI apps. Once you have a design you like, press **🗐 Copy to Clipboard**, and test it in your app.  
  
### Moving Points  
Drag the control **⦿ points** to move them. If you exceed the square canvas, points will snap back to place.  
You can use **⇧ Shift** to select multiple points, and move them together.  
  
### Coloring Points  
When you select any amount of points, pressing a **🔳 Swatch** will color all of them. You can [well, to be implemented, but you will be able to] drag colors from swatch onto specific points, and colors from points to a new swatch spot. Right click a swatch in the sidebar to delete it. [To be implemented!]  
  
### Adding Points  
When you add a point to the canvas, additional points are needed to maintain symmetry of width/height.  
As you hover across the canvas, a line demonstrates along which axis the additional points will be spread. As you hold to place the point, you can see where exactly the other points will be placed.  

You can hold **⇧ Shift** to lock the line in place for more precise control.
You can hold **⌥ Option** to invert the line’s automatic direction.
