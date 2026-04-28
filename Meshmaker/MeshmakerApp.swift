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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(canvasState)
                .onAppear {
                    #if os(macOS)
                    NSWindow.allowsAutomaticWindowTabbing = false
                    #endif
                }
                .containerBackground(
                    .thinMaterial, for: .window
                )
                .toolbarBackgroundVisibility(
                    .hidden, for: .windowToolbar
                )
        }
        .commandsRemoved()
        .commands {
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
