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
                    .shadow(radius: 6, y: 2)
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
        }
    }
}

struct SmallQuickPalette: View {
    @Binding var color: Color
    
    var body: some View {
        HStack(spacing: 3) {
            VStack(spacing: 3) {
                Swatch(color: .brown)   .onTapGesture { color = .brown }    .frame(width: 16, height: 16)
                Swatch(color: .red)     .onTapGesture { color = .red }      .frame(width: 16, height: 16)
                Swatch(color: .orange)  .onTapGesture { color = .orange }   .frame(width: 16, height: 16)
                Swatch(color: .yellow)  .onTapGesture { color = .yellow }   .frame(width: 16, height: 16)
            }
            VStack(spacing: 3) {
                Swatch(color: .green)   .onTapGesture { color = .green }    .frame(width: 16, height: 16)
                Swatch(color: .mint)    .onTapGesture { color = .mint }     .frame(width: 16, height: 16)
                Swatch(color: .teal)    .onTapGesture { color = .teal }     .frame(width: 16, height: 16)
                Swatch(color: .cyan)    .onTapGesture { color = .cyan }     .frame(width: 16, height: 16)
            }
            VStack(spacing: 3) {
                Swatch(color: .blue)    .onTapGesture { color = .blue }     .frame(width: 16, height: 16)
                Swatch(color: .indigo)  .onTapGesture { color = .indigo }   .frame(width: 16, height: 16)
                Swatch(color: .purple)  .onTapGesture { color = .purple }   .frame(width: 16, height: 16)
                Swatch(color: .pink)    .onTapGesture { color = .pink }     .frame(width: 16, height: 16)
            }
        }
    }
}
