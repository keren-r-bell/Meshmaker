//
//  MeshPointItem.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 21/3/26.
//

import SwiftUI

struct PointOnCanvas: View {
    @EnvironmentObject var canvasState: CanvasState
    
    @Binding var meshPoint: MeshPoint
    @State var isPopoverVisible: Bool = false
    
    var body: some View {
        Point(color: meshPoint.color)
            .padding()
            .contentShape(.circle)
            .pointerStyle(canvasState.isHovering ? .grabIdle : .grabActive)
            .onTapGesture {
                canvasState.handleNewSelection(meshPoint, isDragging: false)
                if canvasState.selectedPointIDs.contains(where: { $0 == meshPoint.id } ) && !canvasState.isShiftDown {
                    isPopoverVisible.toggle()
                }
            }
        
            .popover(isPresented: $isPopoverVisible, arrowEdge: .top) {
                PopoverPalette(color: $meshPoint.color)
            }
            .onChange(of: isPopoverVisible) { before, after in
                //print("Popover down, but an existing isn't dragging (so canvas is probably Hovering, right? \(canvasState.isHovering)")
                if after == false && canvasState.isHovering {
                    /// If this is the only point as the popover closed, deselect it.
                    if canvasState.selectedPointIDs == [meshPoint.id] {
                        canvasState.selectedPointIDs = []
                    }
                }
            }
        /*
            .overlay {
                if canvasState.selectedPointIDs.contains(meshPoint.id) {
                    Text("\(Int(meshPoint.x*100))%, \(Int(meshPoint.y*100))%")
                        .frame(width: 64)
                        .lineLimit(1)
                        .font(.caption2)
                        .padding(4)
                        .glassEffect(in: .capsule)
                        .offset(y: 32)
                }
            }
        */
            //code for being dropped a Color property like from a colorpicker or Swatch and changing the color to fit
         
    }
}

