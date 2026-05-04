// CanvasState.swift
import SwiftUI
import Combine

/// An ObservableObject that holds the state and logic for the mesh canvas.
class CanvasState: ObservableObject {
    
    // MARK: Undo/Redo Support
    weak var undoManager: UndoManager?
    
    // Snapshot used to capture the state at the beginning of a drag
    private var pendingDragSnapshot: CanvasSnapshot?
    
    // A lightweight snapshot of the canvas state for undo/redo
    struct CanvasSnapshot {
        var points: [[MeshPoint]]
        var meshWidth: Int
        var meshHeight: Int
        var selectedPointIDs: [UUID]
        var smoothGrads: Bool
    }
    
    // MARK: Mesh Grid State
    @Published var points: [[MeshPoint]] = []
    @Published var meshWidth: Int = 0
    @Published var meshHeight: Int = 0
    @Published var smoothGrads: Bool = true
    
    @Published var selectedPointIDs: [UUID] = []
    @Published var isShiftDown: Bool = false
    @Published var isOptionDown: Bool = false
    
    @Published var ghosts: [MeshPoint] = []
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
    
    // MARK: - Undo/Redo Helpers
    /// Provide the scene's UndoManager from the view layer.
    func setUndoManager(_ manager: UndoManager?) {
        self.undoManager = manager
    }

    /// Create a deep snapshot of the current canvas state.
    private func makeSnapshot() -> CanvasSnapshot {
        CanvasSnapshot(
            points: points,
            meshWidth: meshWidth,
            meshHeight: meshHeight,
            selectedPointIDs: selectedPointIDs,
            smoothGrads: smoothGrads
        )
    }

    /// Apply a snapshot back onto the model.
    private func applySnapshot(_ snapshot: CanvasSnapshot) {
        self.points = snapshot.points
        self.meshWidth = snapshot.meshWidth
        self.meshHeight = snapshot.meshHeight
        self.selectedPointIDs = snapshot.selectedPointIDs
        self.smoothGrads = snapshot.smoothGrads
    }

    /// Register an undo that restores the passed snapshot, and chain a redo.
    private func registerUndo(to snapshot: CanvasSnapshot, actionName: String) {
        undoManager?.registerUndo(withTarget: self) { target in
            // Capture current state for redo before applying the undo snapshot
            let redoSnapshot = target.makeSnapshot()
            target.applySnapshot(snapshot)
            // Chain redo
            target.registerUndo(to: redoSnapshot, actionName: actionName)
        }
        undoManager?.setActionName(actionName)
    }

    /// Convenience to capture the current state and push it to the undo stack.
    private func captureUndoPoint(actionName: String) {
        let snapshot = makeSnapshot()
        registerUndo(to: snapshot, actionName: actionName)
    }
    
    
    func addGhostsToPoints(size: CGSize, cursor: CursorState) {
        //print("I have to do this myself.")
        
        guard !ghosts.isEmpty else { /*print("No ghosts here..."); */return }
        
        if !cursor.orientLineHorizIfTrue {
            //print("Adding a new Column")
            /// All ghosts share the same X
            let newX = ghosts.first!.x
            
            /// Find insertion column index
            var insertIndex = 0
            if let firstRow = points.first {
                insertIndex = firstRow.lastIndex(where: { $0.x < newX }) ?? 0
                insertIndex += 1
            }
            
            /// Sort ghosts by Y to match rows
            var sortedGhosts = ghosts.sorted { $0.y < $1.y }

            /// Reinsert missing point at cursor Y
            let actualNormY = Float(cursor.cursorPosition.y / size.height)
            let insertAt = sortedGhosts.firstIndex(where: { $0.y > actualNormY }) ?? sortedGhosts.count

            let newDotX = ghosts.first!.x
            let newDotY = Float(cursor.cursorPosition.y / size.height)

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
            selectedPointIDs.append(replacement.id)

            /// Ensure count matches height
            guard sortedGhosts.count == meshHeight else {
                //print("Eeeyikes! it seems \(sortedGhosts.count) != target \(meshHeight)")
                return
            }
            
            // Register undo just before committing a new column
            let snapshot = makeSnapshot()
            registerUndo(to: snapshot, actionName: "Insert Column")
            
            /// Insert into each row
            for rowIndex in points.indices {
                points[rowIndex].insert(sortedGhosts[rowIndex], at: insertIndex)
            }
            
            meshWidth += 1
            //print("- Mesh width increased")
        } else {
            //print("Adding a new Row")
            
            let newY = ghosts.first!.y
            
            var insertIndex = 0
            /// the first point from every row
            let firstColumn = points.map { $0.first! }
                insertIndex = firstColumn.lastIndex(where: { $0.y < newY }) ?? 0
                insertIndex += 1
            //print(insertIndex)
            
            /// Sort ghosts by X to match columns
            var sortedGhosts = ghosts.sorted { $0.x < $1.x }

            /// We removed the closest ghost during preview; reinsert a point at the cursor X
            /// NOTE: cursorPosition is already clamped in pixel space; we need normalized X/Y
            /// Recompute normalized cursor
            let actualNormX = Float(cursor.cursorPosition.x / size.width)
            let insertAt = sortedGhosts.firstIndex(where: { $0.x > actualNormX }) ?? sortedGhosts.count

            /// Create a new point at the exact cursor projection (same Y as the new row)
            let newDotY = ghosts.first!.y
            let newDotX = Float(cursor.cursorPosition.x / size.width)

            /// Interpolate color from neighbors if possible
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
            selectedPointIDs.append(replacement.id)
            
            /// Ensure count matches width
            guard sortedGhosts.count == meshWidth else {
                //print("Eeeyikes! it seems \(sortedGhosts.count) != target \(meshWidth)")
                return
            }

            // Register undo just before committing a new row
            let snapshot = makeSnapshot()
            registerUndo(to: snapshot, actionName: "Insert Row")

            meshHeight += 1
            /// Insert row
            points.insert(sortedGhosts, at: insertIndex)
            //print("- Mesh height increased")
            
        }
        //print("I've added so many ghosts!")
        /// Clear ghosts after committing
        ghosts.removeAll()
         
    }
    
    
    /// Currently unused.
    /*
    func updateModifierKeys(old: EventModifiers, new: EventModifiers) {
        self.isShiftDown = new.contains(.shift)
        /// Toggle orientation if Option key state changes.
        if old.contains(.option) != new.contains(.option) {
            self.orientLineHorizIfTrue.toggle()
        }
        self.isOptionDown = new.contains(.option)
    }*/
    
    func applyColorToSelection(_ color: Color) {
        if !selectedPointIDs.isEmpty {
            captureUndoPoint(actionName: "Change Color")
        }
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
            } //else { print("either selected or dragging")}
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
        // Capture the initial state at the start of a drag so we can undo the whole gesture
        if !isFinalizing && pendingDragSnapshot == nil && !selectedPointIDs.isEmpty {
            pendingDragSnapshot = makeSnapshot()
        }
        
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
        
        if isFinalizing {
            if let snapshot = pendingDragSnapshot {
                let actionName = selectedPointIDs.count > 1 ? "Move \(selectedPointIDs.count)  Points" : "Move Point"
                registerUndo(to: snapshot, actionName: actionName)
            }
            pendingDragSnapshot = nil
        }
    }
    
    func fixFrame() {
        captureUndoPoint(actionName: "Fix Frame")
        for index in 0 ..< meshWidth {
            //self.points[0][index].x = (1.0 / Float(meshWidth - 1)) * Float(index)
            self.points[0][index].y = 0.0
        }
        
        for row in 0 ..< points.count {
            self.points[row][0].x = 0.0
            self.points[row][meshWidth - 1].x = 1.0
        }
        
        for index in 0 ..< meshWidth {
            //self.points[meshHeight-1][index].x = (1.0 / Float(meshWidth - 1)) * Float(index)
            self.points[meshHeight-1][index].y = 1.0
        }
    }
    
    func straightenFrame() {
        captureUndoPoint(actionName: "Straighten Frame")
        for index in 0 ..< meshWidth {
            self.points[0][index].x = (1.0 / Float(meshWidth - 1)) * Float(index)
            self.points[0][index].y = 0.0
        }
        
        for row in 1 ..< points.count - 1 {
            let rowY = (1.0 / Float(meshHeight - 1)) * Float(row)
            self.points[row][0].x = 0.0
            self.points[row][0].y = rowY
            self.points[row][meshWidth - 1].x = 1.0
            self.points[row][meshWidth - 1].y = rowY
        }
        
        for index in 0 ..< meshWidth {
            self.points[meshHeight-1][index].x = (1.0 / Float(meshWidth - 1)) * Float(index)
            self.points[meshHeight-1][index].y = 1.0
        }
    }
    
    func straightenMesh() {
        captureUndoPoint(actionName: "Straighten Mesh")
        for row in 0 ..< points.count {
            for index in 0 ..< meshWidth {
                self.points[row][index].x = (1.0 / Float(meshWidth - 1)) * Float(index)
                self.points[row][index].y = (1.0 / Float(meshHeight - 1)) * Float(row)
            }
        }
    }
    
    // MARK: - Computed Properties for View Compatibility
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
    
    // MARK: - Public Undo/Redo API
    func undo() {
        undoManager?.undo()
    }
    
    func redo() {
        undoManager?.redo()
    }

    /// Expose a simple way for views to create an undo step before making direct mutations.
    func markUndoPoint(_ actionName: String) {
        captureUndoPoint(actionName: actionName)
    }

    // MARK: - Templates
    /// Apply a complete mesh template and register undo.
    func applyTemplate(_ preset: [[MeshPoint]], actionName: String = "Apply Template") {
        let snapshot = makeSnapshot()
        // Mutate state
        self.points = preset
        self.meshHeight = preset.count
        self.meshWidth = preset.first?.count ?? 0
        self.selectedPointIDs = []
        // Register undo to restore previous state
        registerUndo(to: snapshot, actionName: actionName)
    }
}

