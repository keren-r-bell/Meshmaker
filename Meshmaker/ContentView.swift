//
//  ContentView.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 21/3/26.
//
import SwiftUI
import TipKit

struct ContentView: View {
    @EnvironmentObject var canvasState: CanvasState
    
    let newPaletteTutorial = NewPaletteTutorial()
    
    var body: some View {
        NavigationStack {
            HStack {
                GeometryReader { geometry in
                    MeshCanvasEditor(geometry: geometry)
                }
                .aspectRatio(1.0, contentMode: .fit)
                .padding(48)
                
                InspectorView()
                    .glassEffect(in: .containerRelative)
                    .padding(12)
                    .frame(width: 300)
            }
/*            .inspector(isPresented: .constant(true)) {
                InspectorView()
            }*/
            .toolbar {
                ToolbarItem {
                    FixFrameButton()
                }
                ToolbarItem {
                    let isAll = canvasState.points.flatMap{ $0 }.count == canvasState.selectedPointIDs.count
                    Button("\(isAll ? "Deselect" : "Select") All Points", systemImage: isAll ? "circle" : "checkmark.circle.fill") {
                        if isAll {
                            canvasState.selectedPointIDs = []
                        } else {
                            canvasState.selectAllPoints()
                        }
                    }
                    .contentTransition(.symbolEffect(.replace.magic(fallback: .upUp)))
                }
                ToolbarSpacer()
                /* ToolbarItemGroup() {
                    Button("Undo", systemImage: "arrow.uturn.backward") {}
                    Button("Redo", systemImage: "arrow.uturn.forward") {}.disabled(true)
                }
                ToolbarSpacer()*/
                ToolbarItem() {
                    PresetMenu()
                        .popoverTip(newPaletteTutorial, arrowEdge: .trailing)
                }
            }

        }
    }
}

struct NewPaletteTutorial: Tip {
    
    @Parameter static var usedInitialBefore: Bool = false
    
    var title: Text {
        Text("Start from Scratch")
    }


    var message: Text? {
        Text("Make your own mesh gradient from basic colors.")
    }


    var image: Image? {
        Image(systemName: "squareshape.split.2x2.dotted.inside")
    }
    
    var rules: [Rule] {
        #Rule(Self.$usedInitialBefore) {
            $0 == false
        }
    }
    var options: [any Option] {
        MaxDisplayCount(3)
        MaxDisplayDuration(60.0)
    }
}
