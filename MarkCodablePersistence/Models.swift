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

struct Parent: Identifiable, Codable {
    var id = UUID().uuidString
    var firstName: String
    var lastName: String
    var children: [String] = []
    var address: Address
}

struct Address: Codable {
    var city: String
    var provState: String
}
