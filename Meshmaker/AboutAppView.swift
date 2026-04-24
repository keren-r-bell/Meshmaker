//
//  AboutAppView.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 7/4/26.
//

import SwiftUI

struct AboutView: View {
    let grads = [
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
        smoothsColors: true),
        MeshGradient(
           width: 4,
           height: 5,
           points: [
               [0, 0], [0.389193, 0], [0.680556, 0], [1, 0],
               [0, 0.319086], [0.219162, 0.821658], [0.521745, 0.269716], [1, 0.319086],
               [0, 0.894412], [0.404905, 0.34158], [0.820464, 0.474772], [1, 0.604351],
               [0, 0.510265], [0.602382, 0.758029], [0.860579, 0.281391], [1, 0.738498],
               [0, 1], [0.176443, 0.99974], [0.680556, 1], [1, 1]
           ],
           colors: [
               .teal, Color(hue: 0.49, saturation: 0.57, brightness: 0.83), Color(hue: 0.47, saturation: 0.47, brightness: 0.84), Color(hue: 0.44, saturation: 0.39, brightness: 0.84),
               Color(hue: 0.42, saturation: 0.34, brightness: 0.84), Color(hue: 0.29, saturation: 0.48, brightness: 0.65), Color(hue: 0.38, saturation: 0.49, brightness: 0.85), Color(hue: 0.20, saturation: 0.40, brightness: 0.85),
               Color(hue: 0.27, saturation: 0.30, brightness: 0.85), Color(hue: 0.28, saturation: 0.28, brightness: 0.85), Color(hue: 0.30, saturation: 0.49, brightness: 0.97), Color(hue: 0.15, saturation: 0.60, brightness: 0.89),
               Color(hue: 0.17, saturation: 0.26, brightness: 1.00), Color(hue: 0.47, saturation: 0.65, brightness: 0.87), Color(hue: 0.21, saturation: 0.37, brightness: 0.85), Color(hue: 0.14, saturation: 0.73, brightness: 0.95),
               Color(hue: 0.18, saturation: 0.44, brightness: 0.85), Color(hue: 0.49, saturation: 0.57, brightness: 0.83), Color(hue: 0.22, saturation: 0.30, brightness: 1.00), .yellow
           ],
           smoothsColors: true
       ),
        MeshGradient(
            width: 5,
            height: 6,
            points: [
                [0, 0], [0.325239, 0], [0.751356, 0], [0.836892, 0], [1, 0],
                [0, 0.143631], [0.399425, 0.18202], [0.751356, 0.166992], [0.836892, 0.166992], [1, 0.166992],
                [0, 0.264269], [0.138954, 0.381], [0.660503, 0.268132], [0.830306, 0.69872], [1, 0.220237],
                [0, 0.403624], [0.145866, 0.269347], [0.475705, 0.467209], [0.890538, 0.296615], [1, 0.511469],
                [0, 0.817079], [0.344922, 0.806456], [0.544738, 0.747179], [0.698275, 0.536371], [1, 0.702506],
                [0, 1], [0.325239, 1], [0.579579, 1], [0.836892, 1], [1, 1]
            ],
            colors: [
                Color(hue: 0.17, saturation: 0.27, brightness: 1.00), Color(hue: 0.17, saturation: 0.81, brightness: 1.00), Color(hue: 0.15, saturation: 0.85, brightness: 0.91), Color(hue: 0.16, saturation: 0.80, brightness: 0.87), Color(hue: 0.17, saturation: 0.76, brightness: 0.84),
                Color(hue: 0.17, saturation: 0.76, brightness: 1.00), Color(hue: 0.17, saturation: 0.51, brightness: 1.00), Color(hue: 0.15, saturation: 0.85, brightness: 0.91), Color(hue: 0.17, saturation: 0.76, brightness: 0.84), Color(hue: 0.20, saturation: 0.70, brightness: 0.84),
                Color(hue: 0.15, saturation: 0.85, brightness: 0.91), Color(hue: 0.15, saturation: 0.85, brightness: 0.91), Color(hue: 0.15, saturation: 0.85, brightness: 0.91), Color(hue: 0.19, saturation: 0.73, brightness: 0.84), Color(hue: 0.24, saturation: 0.65, brightness: 0.83),
                Color(hue: 0.19, saturation: 0.72, brightness: 0.84), Color(hue: 0.18, saturation: 0.74, brightness: 0.84), Color(hue: 0.25, saturation: 0.63, brightness: 0.47), Color(hue: 0.21, saturation: 0.70, brightness: 0.84), Color(hue: 0.30, saturation: 0.61, brightness: 0.83),
                Color(hue: 0.22, saturation: 0.68, brightness: 0.84), Color(hue: 0.22, saturation: 0.68, brightness: 0.84), Color(hue: 0.22, saturation: 0.68, brightness: 0.84), Color(hue: 0.22, saturation: 0.69, brightness: 0.84), Color(hue: 0.33, saturation: 0.60, brightness: 0.82),
                Color(hue: 0.26, saturation: 0.64, brightness: 0.83), Color(hue: 0.30, saturation: 0.69, brightness: 0.88), Color(hue: 0.41, saturation: 0.80, brightness: 0.91), Color(hue: 0.33, saturation: 0.64, brightness: 0.87), .green
            ],
            smoothsColors: true
        ),
        MeshGradient(
            width: 5,
            height: 5,
            points: [
                [0, 0], [0.284494, 0], [0.53788, 0], [0.722852, 0], [1, 0],
                [0, 0.312511], [0.230827, 0.361871], [0.532813, 0.439779], [0.646191, 0.723492], [1, 0.312511],
                [0, 0.502615], [0.237343, 0.671712], [0.677941, 0.196918], [0.819889, 0.502615], [1, 0.502615],
                [0, 0.708876], [0.426476, 0.739898], [0.675922, 0.523491], [0.868652, 0.711513], [1, 0.708876],
                [0, 1], [0.284494, 1], [0.53252, 1], [0.722852, 1], [1, 1]
            ],
            colors: [
                .red, Color(hue: 0.98, saturation: 0.73, brightness: 0.99), Color(hue: 0.02, saturation: 0.52, brightness: 0.98), Color(hue: 0.06, saturation: 1.00, brightness: 0.96), Color(hue: 0.04, saturation: 0.70, brightness: 0.95),
                Color(hue: 0.97, saturation: 0.71, brightness: 0.97), Color(hue: 0.95, saturation: 0.70, brightness: 0.96), Color(hue: 0.94, saturation: 0.70, brightness: 0.95), Color(hue: 0.10, saturation: 0.65, brightness: 1.00), Color(hue: 0.06, saturation: 0.59, brightness: 0.93),
                Color(hue: 0.95, saturation: 0.70, brightness: 0.96), Color(hue: 0.84, saturation: 0.64, brightness: 1.00), Color(hue: 0.91, saturation: 0.53, brightness: 0.84), Color(hue: 0.97, saturation: 0.73, brightness: 1.00), Color(hue: 0.95, saturation: 0.50, brightness: 0.91),
                Color(hue: 0.93, saturation: 0.70, brightness: 0.95), Color(hue: 0.75, saturation: 0.69, brightness: 0.92), Color(hue: 0.91, saturation: 0.69, brightness: 0.92), Color(hue: 0.89, saturation: 0.69, brightness: 0.91), Color(hue: 0.88, saturation: 0.69, brightness: 0.90),
                Color(hue: 0.87, saturation: 0.70, brightness: 0.90), Color(hue: 0.84, saturation: 0.72, brightness: 0.88), Color(hue: 0.81, saturation: 0.72, brightness: 0.79), Color(hue: 0.81, saturation: 0.79, brightness: 0.95), .purple
            ],
            smoothsColors: true
        ),
        MeshGradient(
            width: 3,
            height: 5,
            points: [
                [0, 0], [0.759397, 0], [1, 0],
                [0, 0.421615], [0.759397, 0.454134], [1, 0.181543],
                [0, 0.844293], [0.409896, 0.23214], [1, 0.612923],
                [0, 0.891645], [0.541775, 1], [1, 1],
                [0, 1], [0.254188, 1], [1, 0.48227]
            ],
            colors: [
                Color(hue: 0.17, saturation: 0.36, brightness: 1.00), Color(hue: 0.15, saturation: 0.42, brightness: 0.96), Color(hue: 0.13, saturation: 0.49, brightness: 0.93),
                Color(hue: 0.10, saturation: 0.45, brightness: 0.81), Color(hue: 0.13, saturation: 0.43, brightness: 0.89), Color(hue: 0.10, saturation: 0.45, brightness: 0.81),
                Color(hue: 0.12, saturation: 0.45, brightness: 0.86), Color(hue: 0.05, saturation: 0.45, brightness: 0.79), Color(hue: 0.07, saturation: 0.44, brightness: 0.72),
                Color(hue: 0.13, saturation: 0.45, brightness: 0.90), Color(hue: 0.99, saturation: 0.28, brightness: 0.40), Color(hue: 1.00, saturation: 0.42, brightness: 0.50),
                Color(hue: 0.10, saturation: 0.55, brightness: 0.80), Color(hue: 0.04, saturation: 0.50, brightness: 0.56), .brown
            ],
            smoothsColors: true
        ),
        MeshGradient(
            width: 3,
            height: 6,
            points: [
                [0, 0], [0.885954, 0], [1, 0],
                [0, 0.484201], [0.302242, 0.26588], [1, 0.797721],
                [0, 0.0922431], [0.582495, 0.205872], [1, 0.322167],
                [0, 0.644323], [0.387924, 0.649365], [1, 0.160945],
                [0, 0.724082], [0.603394, 0.425781], [1, 0.724082],
                [0, 1], [0.885954, 1], [1, 1]
            ],
            colors: [
                .yellow, Color(hue: 0.11, saturation: 0.85, brightness: 1.00), Color(hue: 0.09, saturation: 0.78, brightness: 1.00),
                Color(hue: 0.11, saturation: 0.83, brightness: 1.00), Color(hue: 0.14, saturation: 0.69, brightness: 1.00), Color(hue: 0.11, saturation: 0.83, brightness: 1.00),
                Color(hue: 0.10, saturation: 0.80, brightness: 1.00), Color(hue: 0.10, saturation: 0.80, brightness: 1.00), Color(hue: 0.10, saturation: 0.80, brightness: 1.00),
                Color(hue: 0.08, saturation: 0.77, brightness: 1.00), Color(hue: 0.05, saturation: 0.72, brightness: 1.00), Color(hue: 0.08, saturation: 0.77, brightness: 0.90),
                Color(hue: 0.06, saturation: 0.73, brightness: 1.00), Color(hue: 1.00, saturation: 0.63, brightness: 1.00), Color(hue: 0.03, saturation: 0.70, brightness: 1.00),
                Color(hue: 0.03, saturation: 0.70, brightness: 1.00), Color(hue: 0.00, saturation: 0.68, brightness: 1.00), Color(hue: 0.97, saturation: 0.82, brightness: 0.80)
            ],
            smoothsColors: true
        )
    ]
    @State var randomGrad = 0
    
    
    private var appVersionAndBuild: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
        return "Version \(version) (\(build))"
    }
    
    var body: some View {
        ZStack {
            ZStack {
                grads[randomGrad]
                    .onAppear { randomGrad = Int.random(in: 0..<5) }
            }
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
