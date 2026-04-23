//
//  TestingView.swift
//  Meshmaker
//
//  Created by Keren R. Bell on 19/4/26.
//

import SwiftUI

struct TestingView: View {
    var body: some View {
        ScrollView {
            VStack {
                if let doc = loadMarkdown("Testing") {
                    let renderer = MarkdownRenderer()
                    renderer.render(doc)
                }
            }.safeAreaPadding(32)
        }
    }
}

#Preview {
    TestingView()
}

