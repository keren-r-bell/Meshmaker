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
                SmallQuickPalette(color: $startingColor)
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(colors: [startingColor, endingColor], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .stroke(.white, lineWidth: 3)
                    .shadow(radius: 9, y: 5)
                    .frame(width: 128, height: 128)
                SmallQuickPalette(color: $endingColor)
            }
            
            Button("Create") {
                withAnimation(.bouncy) {
                    canvasState.meshHeight = 2
                    canvasState.meshWidth = 2
                    canvasState.points = [
                        [MeshPoint(x: 0.0, y: 0.0, color: startingColor),
                         MeshPoint(x: 1.0, y: 0.0, color: startingColor.mix(with: endingColor, by: 0.3))],
                        [MeshPoint(x: 0.0, y: 1.0, color: endingColor.mix(with: startingColor, by: 0.3)),
                         MeshPoint(x: 1.0, y: 1.0, color: endingColor), ],
                    ]
                    canvasState.selectedPointIDs = []
                }
            }
            
            Spacer()
        }
    }
}

struct SmallQuickPalette: View {
    @Binding var color: Color
    let spacing = 3.0
    
    var body: some View {
        HStack(alignment: .center, spacing: spacing) {
            VStack(spacing: spacing) {
                SetupSwatch(boundColor: $color, color: .purple)
                SetupSwatch(boundColor: $color, color: .pink)
                SetupSwatch(boundColor: $color, color: .red)
                SetupSwatch(boundColor: $color, color: .orange)
                SetupSwatch(boundColor: $color, color: .yellow)
                SetupSwatch(boundColor: $color, color: .brown)
            }
            VStack(spacing: spacing) {
                SetupSwatch(boundColor: $color, color: .green)
                SetupSwatch(boundColor: $color, color: .mint)
                SetupSwatch(boundColor: $color, color: .teal)
                SetupSwatch(boundColor: $color, color: .cyan)
                SetupSwatch(boundColor: $color, color: .blue)
                SetupSwatch(boundColor: $color, color: .indigo)
            }
        }
    }
    
    struct SetupSwatch: View {
        @Binding var boundColor: Color
        var color: Color
        
        var body: some View {
            Swatch(color: color, stroke: boundColor == color ? .blue : .white)
                .onTapGesture {
                    withAnimation {
                        boundColor = color
                    }
                }
                .frame(width: 16, height: 16)
        }
    }
}

