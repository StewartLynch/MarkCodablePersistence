//
// Created for MarkCodable Persistence
// by  Stewart Lynch on 2022-12-22
// Using Swift 5.0
// Running on macOS 13.1
// 
// Folllow me on Mastodon: @StewartLynch@iosdev.space
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch

import SwiftUI

enum Entity: Identifiable, View {
    case family
    case child(Parent)
    var id: String {
        switch self {
        case .family:
            return "family"
        case .child:
            return "child"
        }
    }
    var body: some View {
        switch self {
        case .family:
            return NewEntityView()
        case .child(let parent):
            return NewEntityView(parent: parent)
        }
    }
}
