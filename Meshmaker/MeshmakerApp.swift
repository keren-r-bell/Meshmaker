//
//  MeshmakerApp.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 21/3/26.
//

import SwiftUI
import TipKit
#if os(macOS)
import AppKit
#endif

@main
struct MeshmakerApp: App {
    @Environment(\.openWindow) private var openWindow
    
    @StateObject var canvasState = CanvasState(width: 3, height: 3, preset: preset1)
    @StateObject var cursorState = CursorState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(canvasState)
                .environmentObject(cursorState)
                .onReceive(NotificationCenter.default.publisher(for: .similarColorWillApply)) { _ in
                    canvasState.markUndoPoint("Adjust Color")
                }
                .onAppear {
                    #if os(macOS)
                    NSWindow.allowsAutomaticWindowTabbing = false
                    #endif
                }
#if os(macOS)
                .onReceive(NotificationCenter.default.publisher(for: NSWindow.didMiniaturizeNotification)) { notification in
                    guard let window = notification.object as? NSWindow else { return }
                    let tile = window.dockTile
                    let hostingView = NSHostingView(rootView: MyDockTileView().environmentObject(canvasState))
                    hostingView.frame = NSRect(origin: .zero, size: tile.size)
                    tile.contentView = hostingView
                    tile.display()
                }
#endif
                .containerBackground(
                    .thinMaterial, for: .window
                )
                .toolbarBackgroundVisibility(
                    .hidden, for: .windowToolbar
                )
                .windowFullScreenBehavior(.disabled)
        }
        .commandsRemoved()
        .commands {
            
            InspectorCommands()
            
            CommandGroup(before: .appTermination) {
                Button("About Meshmaker", systemImage: "info.circle") {
                    openWindow(id: "about")
                }
                Divider()
                Button("Close Window") {
                    #if os(macOS)
                    NSApp.keyWindow?.performClose(nil)
                    #endif
                }
                .keyboardShortcut("W")
                Divider()
                Button("Minimize") {
                    NSApplication.shared.miniaturizeAll(nil)
                }.keyboardShortcut("M")
                Button("Hide App") {
                    NSApplication.shared.hide(nil)
                }.keyboardShortcut("H")
                Button("Hide Others") {
                    NSApplication.shared.hideOtherApplications(nil)
                }.keyboardShortcut("H", modifiers: .command.union(.option))
                Divider()
                Button("Quit App", systemImage: "xmark.rectangle", role: .destructive) {
                    NSApplication.shared.terminate(nil)
                }.keyboardShortcut("Q")
            }
            
            CommandGroup(replacing: .help) {
                Button("Meshmaker Tips & Tricks", systemImage: "questionmark") {
                    openWindow(id: "help")
                }
                Button("The Color Palette", systemImage: "paintpalette") {
                    openWindow(id: "colorHelp")
                }
            }
            
            CommandGroup(replacing: .undoRedo) {
                UndoButton().environmentObject(canvasState)
                    .keyboardShortcut("Z")
                RedoButton().environmentObject(canvasState)
                    .keyboardShortcut("Z", modifiers: .command.union(.shift))
            }
            
            CommandMenu("Edit") {
                Button("Copy SwiftUI Code", systemImage: "doc.on.doc") {
                    copyMeshCode(from: canvasState)
                }
                .keyboardShortcut("C", modifiers: .command.union(.shift))
                PresetMenu()
                    .environmentObject(canvasState)
                Divider()
                FixFrameButton()
                    .environmentObject(canvasState)
                Button("Select All Points", systemImage: "checkmark.circle.fill") {
                    canvasState.selectAllPoints()
                }
                .keyboardShortcut("A")
                Button("Deselect All Points", systemImage: "circle.dashed") {
                    canvasState.selectedPointIDs = []
                }
                .disabled(canvasState.selectedPointIDs.isEmpty)
                .keyboardShortcut("A", modifiers: .command.union(.shift))
            }
        }
        
        Window("About Meshmaker", id: "about") {
            AboutView()
                .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
                .toolbar(removing: .title)
                .frame(width: 600, height: 400)
        }
        .commandsRemoved()
        .windowResizability(.contentSize)
        
        Window("Meshmaker Tips & Tricks", id: "help") {
            HelpWindowView()
        }
        .commandsRemoved()
        
        Window("The Color Palette", id: "colorHelp") {
            HelpWindowView(DocName: "ColorHelp")
        }
        .commandsRemoved()
    }
    
    init() {
        do {
            #if DEBUG
            try Tips.resetDatastore()
            #endif
            
            // Configure and load all tips in the app.
            try Tips.configure()
        }
        catch {
            print("Error initializing tips: \(error)")
        }
    }
}

struct MyDockTileView: View {
    @EnvironmentObject var canvasState: CanvasState
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32).fill(.background)
            
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
            .cornerRadius(32)
            
            RoundedRectangle(cornerRadius: 32).stroke(.white, lineWidth: 4)
        }
        .padding(4)
    }
}
