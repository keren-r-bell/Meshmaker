//
//  NewMeshSetup.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 23/4/26.
//

import SwiftUI

struct NewMeshSetup: View {
    @EnvironmentObject var canvasState: CanvasState
    
    @State var startingColor: Color = .orange
    @State var endingColor: Color = .purple
    
    var body: some View {
        VStack {
            Spacer()
            /*HStack {
                ColorPicker("Start", selection: $startingColor)
                
                ColorPicker("End", selection: $endingColor)
                    .position(x: 64, y: 32)
            }
            .labelsHidden()*/
            HStack {
                SmallQuickPalette(boundColor: $startingColor)
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(colors: [startingColor, endingColor], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .stroke(.white, lineWidth: 3)
                    .shadow(radius: 9, y: 5)
                    .frame(width: 128, height: 128)
                SmallQuickPalette(boundColor: $endingColor)
            }
            
            Button("Create") {
                withAnimation(.bouncy) {
                    let preset: [[MeshPoint]] = [
                        [MeshPoint(x: 0.0, y: 0.0, color: startingColor),
                         MeshPoint(x: 1.0, y: 0.0, color: startingColor.mix(with: endingColor, by: 0.3))],
                        [MeshPoint(x: 0.0, y: 1.0, color: endingColor.mix(with: startingColor, by: 0.3)),
                         MeshPoint(x: 1.0, y: 1.0, color: endingColor)]
                    ]
                    canvasState.applyTemplate(preset, actionName: "Create New Mesh")
                }
            }
            
            Spacer()
        }
    }
}

struct SmallQuickPalette: View {
    @Binding var boundColor: Color
    let spacing = 3.0
    
    var colors: [Color] = [.purple, .pink, .red, .orange, .yellow, .brown, .black,
                           .green, .mint, .teal, .cyan, .blue, .indigo, .white]
    
    var body: some View {
        HStack(alignment: .center, spacing: spacing) {
            VStack(spacing: spacing) {
                ForEach(0..<7) { index in
                    SetupSwatch(boundColor: $boundColor, color: colors[index])
                }
            }
            VStack(spacing: spacing) {
                ForEach(7..<14) { index in
                    SetupSwatch(boundColor: $boundColor, color: colors[index])
                }
            }
        }
    }
    
    private struct SetupSwatch: View {
        @Binding var boundColor: Color
        var color: Color
        
        var body: some View {
            Swatch(color: color, stroke: boundColor == color ? .accentColor : .white)
                .onTapGesture {
                    print("Changed something to \(color.description)")
                    withAnimation {
                        boundColor = color
                    }
                }
                .frame(width: 16, height: 16)
        }
    }
}

