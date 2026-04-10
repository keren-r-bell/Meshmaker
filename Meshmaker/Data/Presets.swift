//
//  Presets.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI

let preset0 = [
    [MeshPoint(x: 0.0, y: 0.0, color: .orange), MeshPoint(x: 0.5, y: 0.0, color: .red), MeshPoint(x: 1.0, y: 0.0, color: .red),],
    [MeshPoint(x: 0.0, y: 0.5, color: .yellow), MeshPoint(x: 0.5, y: 0.5, color: .indigo), MeshPoint(x: 1.0, y: 0.5, color: .pink),],
    [MeshPoint(x: 0.0, y: 1.0, color: .cyan), MeshPoint(x: 0.5, y: 1.0, color: .blue), MeshPoint(x: 1.0, y: 1.0, color: .purple)]
]

let preset1 = [
    [MeshPoint(x: 0.0, y: 0.0, color: .white), MeshPoint(x: 1.0, y: 0.0, color: .gray)],
    [MeshPoint(x: 0.0, y: 1.0, color: .gray), MeshPoint(x: 1.0, y: 1.0, color: .black)]
]

let preset2 = [
    [MeshPoint(x: 0.0, y: 0.0, color: .green), MeshPoint(x: 0.33, y: 0.0, color: .mint), MeshPoint(x: 0.66, y: 0.0, color: .teal), MeshPoint(x: 1.0, y: 0.0, color: .cyan)],
    [MeshPoint(x: 0.0, y: 0.33, color: .mint), MeshPoint(x: 0.33, y: 0.33, color: .teal), MeshPoint(x: 0.66, y: 0.33, color: .cyan), MeshPoint(x: 1.0, y: 0.33, color: .blue)],
    [MeshPoint(x: 0.0, y: 0.66, color: .teal), MeshPoint(x: 0.33, y: 0.66, color: .cyan), MeshPoint(x: 0.66, y: 0.66, color: .blue), MeshPoint(x: 1.0, y: 0.66, color: .indigo)],
    [MeshPoint(x: 0.0, y: 1.0, color: .cyan), MeshPoint(x: 0.33, y: 1.0, color: .blue), MeshPoint(x:0.66, y: 1.0, color: .indigo), MeshPoint(x: 1.0, y: 1.0, color: .purple)]
]

let preset3 = [
    [MeshPoint(x: 0.4, y: 0.0, color: .yellow), MeshPoint(x: 0.5, y: 0.0, color: .red), MeshPoint(x: 0.6, y: 0.0, color: .yellow)],
    [MeshPoint(x: 0.4, y: 0.33, color: .red), MeshPoint(x: 0.6, y: 0.33, color: .orange), MeshPoint(x: 0.8, y: 0.33, color: .red)],
    [MeshPoint(x: 0.0, y: 0.66, color: .red), MeshPoint(x:0.35, y: 0.66, color: .red), MeshPoint(x: 0.7, y: 0.66, color: .red)],
    [MeshPoint(x: 0.5, y: 1.0, color: .orange), MeshPoint(x: 0.6, y: 1.0, color: .blue), MeshPoint(x: 0.7, y: 1.0, color: .red)]
]

let preset4 = [
    [MeshPoint(x: 0.0, y: 0.0, color: Color(red: 0.3, green: 0.7, blue: 1.0)), MeshPoint(x: 1.0, y: 0.0, color: Color(red: 0.78, green: 0.62, blue: 1.0))],
    [MeshPoint(x: 0.0, y: 1.0, color: Color(red: 0.72, green: 0.5, blue: 1.0)), MeshPoint(x: 1.0, y: 1.0, color: Color(red: 1.0, green: 0.55, blue: 0.7))]
]


let preset5: [[MeshPoint]] = [
    [MeshPoint(x: 0.0, y: 0.0, color: .red), MeshPoint(x: 0.11, y: 0.0, color: .orange), MeshPoint(x: 0.22, y: 0.0, color: .yellow), MeshPoint(x: 0.33, y: 0.0, color: .green), MeshPoint(x: 0.44, y: 0.0, color: .mint), MeshPoint(x: 0.55, y: 0.0, color: .teal), MeshPoint(x: 0.66, y: 0.0, color: .cyan), MeshPoint(x: 0.77, y: 0.0, color: .blue), MeshPoint(x: 0.88, y: 0.0, color: .indigo), MeshPoint(x: 1.0, y: 0.0, color: .purple)],

    [MeshPoint(x: 0.0, y: 0.11, color: .pink), MeshPoint(x: 0.11, y: 0.11, color: .red), MeshPoint(x: 0.22, y: 0.11, color: .orange), MeshPoint(x: 0.33, y: 0.11, color: .yellow), MeshPoint(x: 0.44, y: 0.11, color: .green), MeshPoint(x: 0.55, y: 0.11, color: .mint), MeshPoint(x: 0.66, y: 0.11, color: .teal), MeshPoint(x: 0.77, y: 0.11, color: .cyan), MeshPoint(x: 0.88, y: 0.11, color: .blue), MeshPoint(x: 1.0, y: 0.11, color: .indigo)],

    [MeshPoint(x: 0.0, y: 0.22, color: .purple), MeshPoint(x: 0.11, y: 0.22, color: .pink), MeshPoint(x: 0.22, y: 0.22, color: .red), MeshPoint(x: 0.33, y: 0.22, color: .orange), MeshPoint(x: 0.44, y: 0.22, color: .yellow), MeshPoint(x: 0.55, y: 0.22, color: .green), MeshPoint(x: 0.66, y: 0.22, color: .mint), MeshPoint(x: 0.77, y: 0.22, color: .teal), MeshPoint(x: 0.88, y: 0.22, color: .cyan), MeshPoint(x: 1.0, y: 0.22, color: .blue)],

    [MeshPoint(x: 0.0, y: 0.33, color: .indigo), MeshPoint(x: 0.11, y: 0.33, color: .purple), MeshPoint(x: 0.22, y: 0.33, color: .pink), MeshPoint(x: 0.33, y: 0.33, color: .red), MeshPoint(x: 0.44, y: 0.33, color: .orange), MeshPoint(x: 0.55, y: 0.33, color: .yellow), MeshPoint(x: 0.66, y: 0.33, color: .green), MeshPoint(x: 0.77, y: 0.33, color: .mint), MeshPoint(x: 0.88, y: 0.33, color: .teal), MeshPoint(x: 1.0, y: 0.33, color: .cyan)],

    [MeshPoint(x: 0.0, y: 0.44, color: .blue), MeshPoint(x: 0.11, y: 0.44, color: .indigo), MeshPoint(x: 0.22, y: 0.44, color: .purple), MeshPoint(x: 0.33, y: 0.44, color: .pink), MeshPoint(x: 0.44, y: 0.44, color: .red), MeshPoint(x: 0.55, y: 0.44, color: .orange), MeshPoint(x: 0.66, y: 0.44, color: .yellow), MeshPoint(x: 0.77, y: 0.44, color: .green), MeshPoint(x: 0.88, y: 0.44, color: .mint), MeshPoint(x: 1.0, y: 0.44, color: .teal)],

    [MeshPoint(x: 0.0, y: 0.55, color: .cyan), MeshPoint(x: 0.11, y: 0.55, color: .blue), MeshPoint(x: 0.22, y: 0.55, color: .indigo), MeshPoint(x: 0.33, y: 0.55, color: .purple), MeshPoint(x: 0.44, y: 0.55, color: .pink), MeshPoint(x: 0.55, y: 0.55, color: .red), MeshPoint(x: 0.66, y: 0.55, color: .orange), MeshPoint(x: 0.77, y: 0.55, color: .yellow), MeshPoint(x: 0.88, y: 0.55, color: .green), MeshPoint(x: 1.0, y: 0.55, color: .mint)],

    [MeshPoint(x: 0.0, y: 0.66, color: .teal), MeshPoint(x: 0.11, y: 0.66, color: .cyan), MeshPoint(x: 0.22, y: 0.66, color: .blue), MeshPoint(x: 0.33, y: 0.66, color: .indigo), MeshPoint(x: 0.44, y: 0.66, color: .purple), MeshPoint(x: 0.55, y: 0.66, color: .pink), MeshPoint(x: 0.66, y: 0.66, color: .red), MeshPoint(x: 0.77, y: 0.66, color: .orange), MeshPoint(x: 0.88, y: 0.66, color: .yellow), MeshPoint(x: 1.0, y: 0.66, color: .green)],

    [MeshPoint(x: 0.0, y: 0.77, color: .mint), MeshPoint(x: 0.11, y: 0.77, color: .teal), MeshPoint(x: 0.22, y: 0.77, color: .cyan), MeshPoint(x: 0.33, y: 0.77, color: .blue), MeshPoint(x: 0.44, y: 0.77, color: .indigo), MeshPoint(x: 0.55, y: 0.77, color: .purple), MeshPoint(x: 0.66, y: 0.77, color: .pink), MeshPoint(x: 0.77, y: 0.77, color: .red), MeshPoint(x: 0.88, y: 0.77, color: .orange), MeshPoint(x: 1.0, y: 0.77, color: .yellow)],

    [MeshPoint(x: 0.0, y: 0.88, color: .green), MeshPoint(x: 0.11, y: 0.88, color: .mint), MeshPoint(x: 0.22, y: 0.88, color: .teal), MeshPoint(x: 0.33, y: 0.88, color: .cyan), MeshPoint(x: 0.44, y: 0.88, color: .blue), MeshPoint(x: 0.55, y: 0.88, color: .indigo), MeshPoint(x: 0.66, y: 0.88, color: .purple), MeshPoint(x: 0.77, y: 0.88, color: .pink), MeshPoint(x: 0.88, y: 0.88, color: .red), MeshPoint(x: 1.0, y: 0.88, color: .orange)],

    [MeshPoint(x: 0.0, y: 1.0, color: .yellow), MeshPoint(x: 0.11, y: 1.0, color: .green), MeshPoint(x: 0.22, y: 1.0, color: .mint), MeshPoint(x: 0.33, y: 1.0, color: .teal), MeshPoint(x: 0.44, y: 1.0, color: .cyan), MeshPoint(x: 0.55, y: 1.0, color: .blue), MeshPoint(x: 0.66, y: 1.0, color: .indigo), MeshPoint(x: 0.77, y: 1.0, color: .purple), MeshPoint(x: 0.88, y: 1.0, color: .pink), MeshPoint(x: 1.0, y: 1.0, color: .red)]
]

