//
//  HelpWindowView.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 7/4/26.
//

import SwiftUI

struct HelpWindowView: View {
    var body: some View {
        ScrollView {
            VStack {
                if let doc = loadMarkdown("HelpDocument") {
                    let renderer = MarkdownRenderer()
                    renderer.render(doc)
                }
            }.safeAreaPadding(24)
        }
    }
}

#Preview {
    HelpWindowView()
}
