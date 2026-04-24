//
//  MeshCanvasEditor.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI

struct MeshCanvasEditor: View {
    @EnvironmentObject var canvasState: CanvasState
    var geometry: GeometryProxy
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.background)
                .stroke(.separator)
            MeshGradient(
                width: canvasState.meshWidth,
                height: canvasState.meshHeight,
                points: canvasState.points.flatMap { row in
                    row.map { SIMD2($0.x, $0.y) }
                },
                colors: canvasState.points.flatMap { row in
                    row.map { $0.color }
                },
                smoothsColors: canvasState.smoothGrads
            )
            .zIndex(1.0)
            
            if canvasState.isMouseDown {
                ForEach(Array($canvasState.ghosts.enumerated()), id: \.offset) { rowIndex, $meshPoint in
                    Point(color: meshPoint.color)
                        .position(
                            x: CGFloat(meshPoint.x) * geometry.size.width,
                            y: CGFloat(meshPoint.y) * geometry.size.height
                        )
                        .zIndex(1.5)
                        .opacity(0.7)
                }
            }
            
            if canvasState.isHovering {
                if canvasState.orientLineHorizIfTrue {
                    Rectangle()
                        .fill(.white.opacity(0.6))
                        .frame(height: 2)
                        .position(x: geometry.size.width / 2, y: canvasState.sharedValue)
                        .shadow(radius: 8, y: 3)
                        .zIndex(2.0)
                } else {
                    Rectangle()
                        .fill(.white.opacity(0.6))
                        .frame(width: 2)
                        .position(x: canvasState.sharedValue, y: geometry.size.height / 2)
                        .shadow(radius: 8, y: 3)
                        .zIndex(2.0)
                }
                
                Point(color: .blue)
                    .allowsHitTesting(false)
                    .position(
                        x: canvasState.orientLineHorizIfTrue ? canvasState.cursorPosition.x : canvasState.sharedValue,
                        y: canvasState.orientLineHorizIfTrue ? canvasState.sharedValue : canvasState.cursorPosition.y
                    )
                    .zIndex(2.5)
            }
            
            ForEach(Array($canvasState.points.enumerated()), id: \.offset) { rowIndex, row in
                ForEach(Array(row.enumerated()), id: \.offset) { colIndex, $meshPoint in
                    PointOnCanvas(meshPoint: $meshPoint)
                        .overlay {
                            if canvasState.selectedPointIDs.contains(meshPoint.id) {
                                Circle()
                                    .stroke(.blue, lineWidth: 3)
                                    .frame(width: 16, height: 16)
                            }
                        }
                        .position(
                            x: CGFloat(meshPoint.x) * geometry.size.width,
                            y: CGFloat(meshPoint.y) * geometry.size.height
                        )
                        .zIndex(3.0)
                    
                        .gesture(
                            DragGesture(minimumDistance: 0.1)
                                .onChanged { value in
                                    if canvasState.isHovering {
                                        //print("And this is a drag!")
                                        canvasState.handleNewSelection(meshPoint, isDragging: true)
                                    }
                                    
                                    canvasState.isHovering = false
                                    let dx = (value.translation.width - canvasState.lastDragTranslation.width) / geometry.size.width
                                    let dy = (value.translation.height - canvasState.lastDragTranslation.height) / geometry.size.height
                                    canvasState.moveSelectedPoints(by: CGSize(width: dx, height: dy))
                                    
                                    canvasState.lastDragTranslation = value.translation
                                }
                                .onEnded { _ in
                                    withAnimation(.snappy) {
                                        canvasState.moveSelectedPoints(by: .zero, isFinalizing: true)
                                        canvasState.lastDragTranslation = .zero
                                    }
                                }
                        )
                }
            }
        }
                                                // MODIFIER KEYS
        .onModifierKeysChanged { old, new in
            canvasState.isShiftDown  = new.contains(.shift)
            if old.contains(.option) != new.contains(.option) {
                canvasState.orientLineHorizIfTrue.toggle()
            }
            canvasState.isOptionDown = new.contains(.option)
        }
                                                // HOVER CANVAS GESTURE
        .onContinuousHover { phase in
            switch phase {
            case .active(let location):
                canvasState.isHovering = true
                canvasState.positionLineAndDot(cursor: location, size: geometry.size)
            case .ended:
                canvasState.isHovering = false
            }
        }
                                                // DRAG NEW DOT GESTURE, ADD GHOSTS
        .gesture (
            DragGesture(minimumDistance: 0.0)
                .onChanged { value in
                    canvasState.selectedPointIDs = []
                    canvasState.isMouseDown = true
                    canvasState.positionLineAndDot(cursor: value.location, size: geometry.size)
                }
                .onEnded { value in
                    canvasState.isMouseDown = false
                    
                    let mouseY = Float(value.location.y / geometry.size.height)
                    let mouseX = Float(value.location.x / geometry.size.width)
                    if mouseY > 1 || mouseY < 0 || mouseX > 1 || mouseX < 0 {
                        print("Cursor out of canvas on drag end, user does not want to place points.")
                    } else {
                        canvasState.addGhostsToPoints(size: geometry.size)
                    }
                }
        )
    }
}
