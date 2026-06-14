//
//  MeshmakerApp.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 21/3/26.
//

import SwiftUI
import TipKit

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
                .frame(minWidth: 640, minHeight: 480)
                .onReceive(NotificationCenter.default.publisher(for: .similarColorWillApply)) { _ in
                    canvasState.markUndoPoint("Adjust Color")
                }
                .onAppear {
                    NSWindow.allowsAutomaticWindowTabbing = false
                }
                .onReceive(NotificationCenter.default.publisher(for: NSWindow.didMiniaturizeNotification)) { notification in
                    guard let window = notification.object as? NSWindow else { return }
                    let tile = window.dockTile
                    let hostingView = NSHostingView(rootView: MyDockTileView().environmentObject(canvasState))
                    hostingView.frame = NSRect(origin: .zero, size: tile.size)
                    tile.contentView = hostingView
                    tile.display()
                }
                .containerBackground(
                    .thinMaterial, for: .window
                )
                .toolbarBackgroundVisibility(
                    .hidden, for: .windowToolbar
                )
                .windowFullScreenBehavior(.disabled)
        }
        .windowIdealSize(.automatic)
        .commandsRemoved()
        .commands {
            InspectorCommands()
            CommandGroup(before: .appTermination) {
                Button("About Meshmaker", systemImage: "info.circle") {
                    openWindow(id: "about")
                }
                Divider()
                Button("Close Window") {
                    NSApp.keyWindow?.performClose(nil)
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
            
            CommandMenu("Edit") {
                UndoButton().environmentObject(canvasState)
                    .keyboardShortcut("Z")
                RedoButton().environmentObject(canvasState)
                    .keyboardShortcut("Z", modifiers: .command.union(.shift))
                Divider()
                Button("Copy SwiftUI Code", systemImage: "doc.on.doc") {
                    copyMeshCode(from: canvasState)
                }
                Button("Import from Code...", systemImage: "square.and.arrow.down") {
                    // Todo: Import code
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


