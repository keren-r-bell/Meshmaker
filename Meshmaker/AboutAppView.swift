//
//  AboutAppView.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 7/4/26.
//

import SwiftUI

struct AboutView: View {
    private var appVersionAndBuild: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
        return "Version \(version) (\(build))"
    }
    
    var body: some View {
        ZStack {
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.00, 0.00], [0.53, 0.00], [1.00, 0.00],
                    [0.00, 0.39], [0.41, 0.61], [1.00, 0.34],
                    [0.00, 1.00], [0.53, 1.00], [1.00, 1.00]
                ],
                colors: [
                    Color(hue: 0.57, saturation: 0.70, brightness: 1.00), Color(hue: 0.63, saturation: 0.41, brightness: 1.00), Color(hue: 0.88, saturation: 0.21, brightness: 1.00),
                    Color(hue: 0.74, saturation: 0.50, brightness: 1.00), Color(hue: 0.94, saturation: 0.45, brightness: 1.00), Color(hue: 0.94, saturation: 0.31, brightness: 1.00),
                    Color(hue: 0.78, saturation: 0.56, brightness: 0.95), Color(hue: 0.65, saturation: 0.44, brightness: 1.00), Color(hue: 0.65, saturation: 0.54, brightness: 1.00)
                ],
                smoothsColors: true
            )
            .opacity(0.3)
            .ignoresSafeArea(.all)
            
            VStack {
                Text("Meshmaker")
                    .font(.system(size: 72, weight: .thin))
                    .fontWidth(.expanded)
                
                HStack(alignment: .lastTextBaseline) {
                    Label("Keren R. Bell", systemImage: "heart")
                        .font(.system(size: 24, weight: .light))
                        .fontWidth(.condensed)
                    VStack(alignment: .leading, spacing: 2) {
                        Link(destination: URL(string: "https://kirby.pika.page/")!) {
                            Label("My Blog", systemImage: "globe")
                        }
                        Link(destination: URL(string: "https://kirby.pika.page/")!) {
                            Label("My Bluesky", systemImage: "at.circle.fill")
                        }
                    }
                    .font(.caption)
                }
                .padding()
                .glassEffect(.clear)
                
                Text(appVersionAndBuild)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
    }
}

#Preview {
    AboutView()
}
