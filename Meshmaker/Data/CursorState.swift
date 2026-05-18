//
//  CursorState.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 4/5/26.
//

import SwiftUI
import Combine

class CursorState: ObservableObject {
    @Published var isHoveringCanvas = false
    @Published var cursorPosition: CGPoint = .zero
    @Published var isDraggingNew = false
    
    @Published var orientLineHorizIfTrue = true
    @Published var sharedValue: CGFloat = 0
    
    @Published var lastDragTranslation: CGSize = .zero
    @Published var indexToUpdate: Int = 0
    
    func orientLine(cursor: CGPoint, size: CGSize) {
        let distFromTop = cursor.y
        let distFromBottom = size.height - cursor.y
        let lowDistFromVerts = min(distFromTop, distFromBottom)
        
        let distFromLeft = cursor.x
        let distFromRight = size.width - cursor.x
        let lowDistFromHoris = min(distFromLeft, distFromRight)
        
        orientLineHorizIfTrue = lowDistFromVerts < lowDistFromHoris
    }
    
    func positionLineAndDot(cursor: CGPoint, size: CGSize, canvas: CanvasState) {
        if !isDraggingNew {
            if !canvas.isShiftDown {
                orientLine(cursor: cursor, size: size)
            }
        } else {
            positionGhosts(size: size, canvas: canvas)
        }
        
        self.cursorPosition = CGPoint(
            x: max(0, min(cursor.x, size.width)),
            y: max(0, min(cursor.y, size.height))
        )
        
        if !canvas.isShiftDown {
            sharedValue = orientLineHorizIfTrue ? self.cursorPosition.y : self.cursorPosition.x
        }
    }
    
    func positionGhosts(size: CGSize, canvas: CanvasState) {
        var newGhosts: [MeshPoint] = []
        /// Calculate relative positions based on current orientation and shared value.
        let relativeX = Float((orientLineHorizIfTrue ? cursorPosition.x : sharedValue) / size.width)
        let relativeY = Float((orientLineHorizIfTrue ? sharedValue : cursorPosition.y) / size.height)
        
        if orientLineHorizIfTrue {
            for columnIndex in 0..<canvas.meshWidth {
                /// Ensure there are enough rows to form a column.
                guard canvas.points.count > 0 && canvas.points[0].count > columnIndex else { continue }
                let column = canvas.points.map { $0[columnIndex] } // Extract points in this column.
                
                /// Find the index of the point just below the target relativeY.
                indexToUpdate = column.lastIndex(where: { $0.y < relativeY } ) ?? 0
                
                /// Ensure indexToUpdate is within column bounds.
                guard indexToUpdate < column.count else { continue }
                
                let prev = column[indexToUpdate]
                /// Get the next point, handling boundary cases.
                let nextIndex = min(indexToUpdate + 1, column.count - 1)
                let next = column[nextIndex]
                
                /// Interpolate X position and color for the ghost.
                let avgX = (prev.x + next.x) / 2.0
                let avgColor = Color(prev.color.mix(with: next.color, by: 0.5)) // Assumes Color.mix method.
                let ghost = MeshPoint(x: avgX, y: relativeY, color: avgColor)
                newGhosts.append(ghost)
            }
        } else {
            /// Logic for when the helper line is vertical (adjusting X).
            for row in canvas.points {
                /// Find the index of the point just left of the target relativeX.
                indexToUpdate = row.lastIndex(where: { $0.x < relativeX } ) ?? 0
                
                /// Ensure indexToUpdate is within row bounds.
                guard indexToUpdate < row.count else { continue }

                let prev = row[indexToUpdate]
                /// Get the next point, handling boundary cases.
                let nextIndex = min(indexToUpdate + 1, row.count - 1)
                let next = row[nextIndex]
                
                /// Interpolate Y position and color for the ghost.
                let avgY = (prev.y + next.y) / 2.0
                let avgColor = Color(prev.color.mix(with: next.color, by: 0.5))
                let ghost = MeshPoint(x: relativeX, y: avgY, color: avgColor)
                newGhosts.append(ghost)
            }
        }
        
        /// Remove the ghost closest to the absolute cursor position.
        let ignoredGhost = newGhosts.min(by: {
            let distA = hypot($0.x - Float(cursorPosition.x / size.width), $0.y - Float(cursorPosition.y / size.height))
            let distB = hypot($1.x - Float(cursorPosition.x / size.width), $1.y - Float(cursorPosition.y / size.height))
            return distA < distB
        })
        newGhosts.removeAll { ignoredGhost?.id == $0.id }
        
        //withAnimation(.snappy) {
            canvas.ghosts = newGhosts
        //}
    }
}
