// CanvasState.swift
import SwiftUI
import Combine

/// An ObservableObject that holds the state and logic for the mesh canvas.
class CanvasState: ObservableObject {
    
    // MARK: Mesh Grid State
    @Published var points: [[MeshPoint]] = []
    
    @Published var meshWidth: Int = 0
    @Published var meshHeight: Int = 0
    @Published var smoothGrads: Bool = true
    // MARK: Interaction and Selection State
    @Published var selectedPointIDs: [UUID] = []
    var allPointBindings: [Binding<MeshPoint>] {
        points.indices.flatMap { row in
            points[row].indices.map { col in
                Binding(
                    get: { self.points[row][col] },
                    set: { self.points[row][col] = $0 }
                )
            }
        }
    }
    
    @Published var isHovering: Bool = false
    @Published var cursorPosition: CGPoint = .zero
    
    @Published var isMouseDown: Bool = false
    @Published var lastDragTranslation: CGSize = .zero
    
    @Published var isShiftDown: Bool = false
    @Published var isOptionDown: Bool = false
    
    // MARK: Helper and Ghost Elements State
    @Published var ghosts: [MeshPoint] = []
    @Published var orientLineHorizIfTrue: Bool = true
    var sharedValue: CGFloat = 0.0
    
    // MARK: Internal State
    var indexToUpdate: Int = 0
    
    // MARK: Initializers
    init(width: Int = 3, height: Int = 3, preset: [[MeshPoint]]? = nil) {
        self.meshWidth = width
        self.meshHeight = height
        
        if let initialPoints = preset {
            self.points = initialPoints
        } else {
            // Create a default grid if no preset is provided.
            // This default ensures the grid has some points to work with.
            // Note: Ensure MeshPoint and Color.mix are available in scope.
            self.points = Array(repeating: Array(repeating: MeshPoint(x: 0.5, y: 0.5, color: .gray), count: width), count: height)
        }
    }
    
    // MARK: Methods
    
    func orientLine(cursor: CGPoint, size: CGSize) {
        let distFromTop = cursor.y
        let distFromBottom = size.height - cursor.y
        let lowDistFromVerts = min(distFromTop, distFromBottom)
        
        let distFromLeft = cursor.x
        let distFromRight = size.width - cursor.x
        let lowDistFromHoris = min(distFromLeft, distFromRight)
        
        orientLineHorizIfTrue = lowDistFromVerts < lowDistFromHoris
    }
    
    
    func positionLineAndDot(cursor: CGPoint, size: CGSize) {
        if !isMouseDown {
            if !isShiftDown {
                orientLine(cursor: cursor, size: size)
            }
        } else {
            positionGhosts(size: size)
        }
        
        self.cursorPosition = CGPoint(
            x: max(0, min(cursor.x, size.width)),
            y: max(0, min(cursor.y, size.height))
        )
        
        if !isShiftDown {
            sharedValue = orientLineHorizIfTrue ? self.cursorPosition.y : self.cursorPosition.x
        }
    }
    
    
    func positionGhosts(size: CGSize) {
        var newGhosts: [MeshPoint] = []
        // Calculate relative positions based on current orientation and shared value.
        let relativeX = Float((orientLineHorizIfTrue ? cursorPosition.x : sharedValue) / size.width)
        let relativeY = Float((orientLineHorizIfTrue ? sharedValue : cursorPosition.y) / size.height)
        
        if orientLineHorizIfTrue {
            for columnIndex in 0..<meshWidth {
                // Ensure there are enough rows to form a column.
                guard points.count > 0 && points[0].count > columnIndex else { continue }
                let column = points.map { $0[columnIndex] } // Extract points in this column.
                
                // Find the index of the point just below the target relativeY.
                indexToUpdate = column.lastIndex(where: { $0.y < relativeY } ) ?? 0
                
                // Ensure indexToUpdate is within column bounds.
                guard indexToUpdate < column.count else { continue }
                
                let prev = column[indexToUpdate]
                // Get the next point, handling boundary cases.
                let nextIndex = min(indexToUpdate + 1, column.count - 1)
                let next = column[nextIndex]
                
                // Interpolate X position and color for the ghost.
                let avgX = (prev.x + next.x) / 2.0
                let avgColor = Color(prev.color.mix(with: next.color, by: 0.5)) // Assumes Color.mix method.
                let ghost = MeshPoint(x: avgX, y: relativeY, color: avgColor)
                newGhosts.append(ghost)
            }
        } else {
            // Logic for when the helper line is vertical (adjusting X).
            for row in points {
                // Find the index of the point just left of the target relativeX.
                indexToUpdate = row.lastIndex(where: { $0.x < relativeX } ) ?? 0
                
                // Ensure indexToUpdate is within row bounds.
                guard indexToUpdate < row.count else { continue }

                let prev = row[indexToUpdate]
                // Get the next point, handling boundary cases.
                let nextIndex = min(indexToUpdate + 1, row.count - 1)
                let next = row[nextIndex]
                
                // Interpolate Y position and color for the ghost.
                let avgY = (prev.y + next.y) / 2.0
                let avgColor = Color(prev.color.mix(with: next.color, by: 0.5)) // Assumes Color.mix method.
                let ghost = MeshPoint(x: relativeX, y: avgY, color: avgColor)
                newGhosts.append(ghost)
            }
        }
        
        // Remove the ghost closest to the absolute cursor position to avoid visual clutter.
        let ignoredGhost = newGhosts.min(by: {
            let distA = hypot($0.x - Float(cursorPosition.x / size.width), $0.y - Float(cursorPosition.y / size.height))
            let distB = hypot($1.x - Float(cursorPosition.x / size.width), $1.y - Float(cursorPosition.y / size.height))
            return distA < distB
        })
        newGhosts.removeAll { ignoredGhost?.id == $0.id }
        
        // Update the published ghosts array with animation.
        //withAnimation(.snappy) {
            self.ghosts = newGhosts
        //}
    }
    
    func addGhostsToPoints(size: CGSize) {
        print("I have to do this myself.")
        /*
        guard !ghosts.isEmpty else { print("No ghosts here..."); return }
        
        if orientLineHorizIfTrue {
            print("Adding a new Row")
            // All ghosts share the same Y
            let newY = ghosts.first!.y
            
            // Find insertion row index
            var insertIndex = 0
            if let firstColumn = points.first {
                insertIndex = firstColumn.lastIndex(where: { $0.y < newY }) ?? 0
                insertIndex += 1
            }
            
            // Sort ghosts by X to match columns
            var sortedGhosts = ghosts.sorted { $0.x < $1.x }

            // We removed the closest ghost during preview; reinsert a point at the cursor X
            // NOTE: cursorPosition is already clamped in pixel space; we need normalized X/Y
            // Recompute normalized cursor
            let actualNormX = Float(cursorPosition.x / size.width)
            let insertAt = sortedGhosts.firstIndex(where: { $0.x > actualNormX }) ?? sortedGhosts.count

            // Create a new point at the exact cursor projection (same Y as the new row)
            let newDotY = ghosts.first!.y
            let newDotX = Float(cursorPosition.x / size.width)

            // Interpolate color from neighbors if possible
            let prev = insertAt > 0 ? sortedGhosts[insertAt - 1] : nil
            let next = insertAt < sortedGhosts.count ? sortedGhosts[insertAt] : nil
            let newColor: Color = {
                if let p = prev, let n = next {
                    return Color(p.color.mix(with: n.color, by: 0.5))
                } else if let p = prev {
                    return p.color
                } else if let n = next {
                    return n.color
                } else {
                    return .gray
                }
            }()

            let replacement = MeshPoint(x: newDotX, y: newDotY, color: newColor)
            sortedGhosts.insert(replacement, at: insertAt)

            // Ensure count matches width
            guard sortedGhosts.count == meshWidth else {
                print("Eeeyikes! it seems \(sortedGhosts.count) != target \(meshWidth)")
                return
            }

            // Insert row
            points.insert(sortedGhosts, at: insertIndex)
            meshHeight += 1
            print("- Mesh height increased")
        } else {
            print("Adding a new Column")
            // All ghosts share the same X
            let newX = ghosts.first!.x
            
            // Find insertion column index
            var insertIndex = 0
            if let firstRow = points.first {
                insertIndex = firstRow.lastIndex(where: { $0.x < newX }) ?? 0
                insertIndex += 1
            }
            
            // Sort ghosts by Y to match rows
            var sortedGhosts = ghosts.sorted { $0.y < $1.y }

            // Reinsert missing point at cursor Y
            let actualNormY = Float(cursorPosition.y / size.height)
            let insertAt = sortedGhosts.firstIndex(where: { $0.y > actualNormY }) ?? sortedGhosts.count

            let newDotX = ghosts.first!.x
            let newDotY = Float(cursorPosition.y / size.height)

            let prev = insertAt > 0 ? sortedGhosts[insertAt - 1] : nil
            let next = insertAt < sortedGhosts.count ? sortedGhosts[insertAt] : nil
            let newColor: Color = {
                if let p = prev, let n = next {
                    return Color(p.color.mix(with: n.color, by: 0.5))
                } else if let p = prev {
                    return p.color
                } else if let n = next {
                    return n.color
                } else {
                    return .gray
                }
            }()

            let replacement = MeshPoint(x: newDotX, y: newDotY, color: newColor)
            sortedGhosts.insert(replacement, at: insertAt)

            // Ensure count matches height
            guard sortedGhosts.count == meshHeight else {
                print("Eeeyikes! it seems \(sortedGhosts.count) != target \(meshHeight)")
                return
            }
            
            // Insert into each row
            for rowIndex in points.indices {
                points[rowIndex].insert(sortedGhosts[rowIndex], at: insertIndex)
            }
            
            meshWidth += 1
            print("- Mesh width increased")
        }
        print("I've added so many ghosts!")
        // Clear ghosts after committing
        ghosts.removeAll()
         */
    }
    
    
    
    func updateModifierKeys(old: EventModifiers, new: EventModifiers) {
        self.isShiftDown = new.contains(.shift)
        // Toggle orientation if Option key state changes.
        if old.contains(.option) != new.contains(.option) {
            self.orientLineHorizIfTrue.toggle()
        }
        self.isOptionDown = new.contains(.option)
    }
    
    func applyColorToSelection(_ color: Color) {
        for binding in allPointBindings {
            if selectedPointIDs.contains(binding.wrappedValue.id) {
                binding.wrappedValue.color = color
            }
        }
    }
    
    func selectAllPoints() {
        selectedPointIDs = []
        for binding in allPointBindings {
            selectedPointIDs.append(binding.wrappedValue.id)
        }
    }
    func handleNewSelection(_ point: MeshPoint, isDragging: Bool) {
        let isSelectedAlready = selectedPointIDs.contains(point.id)
        
        if !isShiftDown {
            if !isSelectedAlready || !isDragging {
                selectedPointIDs = []
            } else { print("either selected or dragging")}
        } else {
            if !isDragging && isSelectedAlready {
                selectedPointIDs.removeAll(where: { $0 == point.id } )
            }
        }
        if !isSelectedAlready {
            selectedPointIDs.append(point.id)
        }
    }
    
    func moveSelectedPoints(by delta: CGSize, isFinalizing: Bool = false) {
        for binding in allPointBindings {
            if selectedPointIDs.contains(binding.wrappedValue.id) {
                binding.wrappedValue.x += Float(delta.width)
                binding.wrappedValue.y += Float(delta.height)
                
                // optional but recommended clamp
                if isFinalizing {
                    withAnimation(.snappy) {
                        binding.wrappedValue.x = min(1.0, max(0.0, binding.wrappedValue.x))
                        binding.wrappedValue.y = min(1.0, max(0.0, binding.wrappedValue.y))
                    }
                }
            }
        }
    }
    
    
    // MARK: - Computed Properties for View Compatibility
    
    /// Provides a flattened array of SIMD2<Float> positions for compatible views like MeshGradient.
    var flattenedSIMD2Points: [SIMD2<Float>] {
        points.flatMap { row in
            row.map { SIMD2($0.x, $0.y) }
        }
    }
    
    /// Provides a flattened array of Colors for compatible views like MeshGradient.
    var flattenedColors: [Color] {
        points.flatMap { row in
            row.map { $0.color }
        }
    }
    
    /// Provides a flattened array of MeshPoint for direct use where needed.
    var flattenedMeshPoints: [MeshPoint] {
        points.flatMap { $0 }
    }
}
