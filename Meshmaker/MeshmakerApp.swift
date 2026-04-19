//
//  MeshmakerApp.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 21/3/26.
//

import SwiftUI

@main
struct MeshmakerApp: App {
    @Environment(\.openWindow) private var openWindow
    
    @StateObject var canvasState = CanvasState(width: 3, height: 3, preset: preset0)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(canvasState)
                .onAppear {
                    #if os(macOS)
                    NSWindow.allowsAutomaticWindowTabbing = false
                    #endif
                }
        }
        .commandsRemoved()
        .commands {
            CommandGroup(before: .appInfo) {
                Button("About Meshmaker", systemImage: "info.circle") {
                    openWindow(id: "about")
                }
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
                Button("Meshmaker Tips & Tricks", systemImage: "questionmark.square.fill") {
                    openWindow(id: "help")
                }
            }
            
            CommandMenu("Edit") {
                PresetMenu()
                    .environmentObject(canvasState)
                Divider()
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
    }
}
