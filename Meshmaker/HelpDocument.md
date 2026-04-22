# Meshmaker  
  
**Meshmaker** lets you create Mesh Gradient elements for your SwiftUI code in an easily, precise canvas.  
  
This app was made because of how frustrating I found coding even simple placeholder visuals was using the very visually pleasing [MeshGradient](https://developer.apple.com/documentation/SwiftUI/MeshGradient) structure, so I figured someone should make a tool for it, and despite some options existing online, I still felt compelled to make my own. But, enough personal stories.  
  
---
### Starting Off  
The program opens with a classic preset. You can get familiar with using Meshmaker by toying with the additional presets, using the **⊞** button on the top-right.  
The point of the program is to use your design in SwiftUI apps. Once you have a design you like, press **🗐 Copy to Clipboard**, and test it in your app.  
    
---
### Moving Points  
Drag the control **🔘 points** to move them. If you exceed the square canvas, points will snap back to place.  
You can use **⇧ Shift** to select multiple points, and move them together.  
    
---
### Coloring Points  
**Selected points** appear in the Sidebar, where you can adjust their color, or change them entirely (To be implemented!).  
In the selected color's row, you can subtly adjust the hue, saturation and brightness of the center color.  

Above the point list, are **🔲 Swatches**. When you select one of them, all selected points will change to its color. To quickly begin iterating from a color, select all points (**⌘ + A**), pick a swatch, and begin iterating.
  
---
### Adding Points  
When you add a point to the canvas, additional points are needed to maintain symmetry of width/height.  
As you hover across the canvas, a line demonstrates along which axis the additional points will be spread. As you hold to place the point, you can see where exactly the other points will be placed.  

You can hold **⇧ Shift** to lock the line in place for more precise control.  
You can hold **⌥ Option** to invert the line’s automatic direction.

---
### Finishing Up
To use the Mesh Gradient you made, press **🗐 Copy to Clipboard**, and paste it in your SwiftUI project.  
Your code should look something like this:
```swift
MeshGradient(
    width: 2,
    height: 2,
    points: [
        [0, 0], [1, 0],
        [0, 1], [1, 1]
    ],
    colors: [
        Color(hue: 0.57, saturation: 0.70, brightness: 1.00), Color(hue: 0.74, saturation: 0.38, brightness: 1.00),
        Color(hue: 0.74, saturation: 0.50, brightness: 1.00), Color(hue: 0.94, saturation: 0.45, brightness: 1.00)
    ],
    smoothsColors: true
)
```
