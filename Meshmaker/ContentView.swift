//
//  ContentView.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 21/3/26.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var canvasState: CanvasState
    
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
                }
            }

        }
    }
}
