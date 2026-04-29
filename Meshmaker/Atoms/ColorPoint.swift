//
//  Color Point.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 6/4/26.
//

import SwiftUI

struct Point: View {
    var color: Color
    
    var body: some View {
        Circle()
            .fill(color)
            .stroke(.white, lineWidth: 3)
            .frame(width: 16, height: 16)
            .shadow(radius: 4, y: 3)
    }
}
