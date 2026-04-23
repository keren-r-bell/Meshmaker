//
//  MarkdownRenderer.swift
//  Meshmaker
//
//  Created by Keren R. Bell & Claude on 19/4/26.
//


import SwiftUI
import Markdown


func loadMarkdown(_ doc: String) -> Document? {
    guard let url = Bundle.main.url(forResource: doc, withExtension: "md"),
          let text = try? String(contentsOf: url, encoding: .utf8)
    else { return nil }
    return Document(parsing: text)
}


final class MarkdownRenderer: MarkupVisitor {
    typealias Result = AnyView

    // MARK: - Entry point
    func render(_ document: Document) -> AnyView {
        var renderer = self
        return renderer.visit(document)
    }

    // MARK: - Block nodes

    func visitDocument(_ document: Document) -> AnyView {
        AnyView(
            VStack(alignment: .leading, spacing: 3) {
                var renderer = self
                ForEach(Array(document.children.enumerated()), id: \.offset) { _, child in
                    renderer.visit(child)
                }
            }
        )
    }

    func visitParagraph(_ paragraph: Paragraph) -> AnyView {
        AnyView(
            Text(inlineChildren(of: paragraph))
                .font(.system(size: 14))
        )
    }

    func visitHeading(_ heading: Heading) -> AnyView {
        let text = inlineChildren(of: heading)
        switch heading.level {
        case 1:
            return AnyView(
                Text(text)
                    .font(.system(size: 27, design: .rounded))
                    .bold()
                    .padding(.bottom, 6)
            )
        case 2:
            return AnyView(
                Text(text)
                    .font(.system(size: 21))
                    .bold()
                    .padding(.top, 14)
                    .padding(.bottom, 8)
            )
        case 3:
            return AnyView(
                Text(text)
                    .font(.system(size: 18))
                    .bold()
                    .padding(.top, 11)
                    .padding(.bottom, 4)
            )
        case 4:
            return AnyView(
                Text(text)
                    .font(.system(size: 16))
                    .bold()
            )
        default:
            return AnyView(Text(text).font(.headline))
        }
    }
    
    func visitThematicBreak(_ thematicBreak: ThematicBreak) -> AnyView {
        return AnyView (
            Divider()
                .padding(.top, 18)
        )
    }
    
    func visitCodeBlock(_ codeBlock: CodeBlock) -> AnyView {
        return AnyView(
            Text(codeBlock.code)
                .font(.system(.body, design: .monospaced))
                .padding(6)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.background.shadow(.inner(color: .black.opacity(0.3), radius: 5, x: 1, y: 1)))
                        
                }
        )
    }

    func visitUnorderedList(_ list: UnorderedList) -> AnyView {
        AnyView(
            VStack(alignment: .leading, spacing: 4) {
                var renderer = self
                ForEach(Array(list.listItems.enumerated()), id: \.offset) { _, item in
                    HStack(alignment: .top) {
                        Text("•")
                        renderer.visit(item)
                    }
                }
            }
        )
    }

    func visitListItem(_ listItem: ListItem) -> AnyView {
        AnyView(
            VStack(alignment: .leading) {
                var renderer = self
                ForEach(Array(listItem.children.enumerated()), id: \.offset) { _, child in
                    renderer.visit(child)
                }
            }
        )
    }

    func defaultVisit(_ markup: any Markup) -> AnyView {
        AnyView(EmptyView())
    }

    // MARK: - Inline nodes → AttributedString

    // Collects inline children (text, bold, italic, code) into one AttributedString
    // so they compose naturally inside a single Text view
    private func inlineChildren(of markup: any Markup) -> AttributedString {
        markup.children.reduce(into: AttributedString()) { result, child in
            result += inlineNode(child)
        }
    }

    private func inlineNode(_ markup: any Markup) -> AttributedString {
        switch markup {
        case let text as Markdown.Text:
            return AttributedString(text.string)

        case let strong as Strong:
            var attr = inlineChildren(of: strong)
            attr.font = .body.bold()
            return attr

        case let em as Emphasis:
            var attr = inlineChildren(of: em)
            attr.font = .body.italic()
            return attr

        case let code as InlineCode:
            var attr = AttributedString(code.code + " ")
            attr.font = .system(.body, design: .monospaced)
            attr.backgroundColor = Color(.systemFill)
            return attr

        case let link as Markdown.Link:
            var attr = inlineChildren(of: link)
            attr.underlineStyle = .single
            attr.foregroundColor = .accent
            attr.cursor = .pointingHand
            if let dest = link.destination, let url = URL(string: dest) {
                attr.link = url
            }
            return attr
            
        default:
            return AttributedString()
        }
    }
}
