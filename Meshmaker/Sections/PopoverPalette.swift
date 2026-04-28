//
//  PopoverPalette.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI
import TipKit

struct PopoverPalette: View {
    @Environment(\.openWindow) private var openWindow
    
    let tutorialTip = ColorPaletteTutorialTip()
    
    @Binding var color: Color
    
    var body: some View {
        VStack {
            ColorInputField(color: $color)
            
            SimilarColors(color: $color)
        }
        .padding(8)
        .frame(width: 140, height: 100)
        
        .popoverTip(tutorialTip, arrowEdge: .bottom) { action in
            if action.id == "goToTutorial" {
                openWindow(id: "colorHelp")
            }
        }
    }
}


struct ColorPaletteTutorialTip: Tip {
    @Parameter static var pressedColorsBefore: Bool = false
    
    var title: Text {
        Text("Match Beautiful Colors")
    }


    var message: Text? {
        Text("Find out how to quickly change and alter colors.")
    }


    var image: Image? {
        Image(systemName: "paintpalette")
    }
    
    var actions: [Action] {
        Action(id: "goToTutorial", title: "Learn More")
    }
    
    var rules: [Rule] {
        #Rule(Self.$pressedColorsBefore) {
            $0 == false
        }
    }
    var options: [any Option] {
        MaxDisplayCount(3)
        MaxDisplayDuration(60.0)
    }
}
