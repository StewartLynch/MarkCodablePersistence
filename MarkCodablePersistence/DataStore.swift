//
// Created for MarkCodable Persistence
// by  Stewart Lynch on 2022-12-22
// Using Swift 5.0
// Running on macOS 13.1
// 
// Folllow me on Mastodon: @StewartLynch@iosdev.space
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch

import Foundation
import MarkCodable

class DataStore: ObservableObject {
    @Published var parents: [Parent] = []
    @Published var entity: Entity?
    
    init() {
        loadFamilies()
    }

    func addChild(_ child: String, for parent: Parent) {
        if let index = parents.firstIndex(where: { $0.id == parent.id }) {
            parents[index].children.append(child)
            save()
        }
    }

    func addFamily(parent: Parent) {
        parents.append(parent)
        save()
    }

    func deleteFamily(parent: Parent) {
        if let index = parents.firstIndex(where: { $0.id == parent.id }) {
            parents.remove(at: index)
            save()
        }
    }

    func deleteChild(child: String, for parent: Parent) {
        if let index = parents.firstIndex(where: { $0.id == parent.id }) {
            if let childIndex = parents[index].children.firstIndex(where: { $0 == child}) {
                parents[index].children.remove(at: childIndex)
                save()
            }
        }
    }
    
    func save() {
        // JSON
//        do {
//            let jsonURL = URL.documentsDirectory.appending(path: "Family.json")
//            let parentsData = try JSONEncoder().encode(parents)
//            try parentsData.write(to: jsonURL)
//        } catch {
//            print(error.localizedDescription)
//        }
        
        // MarkDown
        do {
            let markDownURL = URL.documentsDirectory.appending(path: "Family.md")
            let parentString = try MarkEncoder().encode(parents)
            try parentString.write(to: markDownURL, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFamilies() {
        // JSON
//        let jsonURL = URL.documentsDirectory.appending(path: "Family.json")
//        if FileManager().fileExists(atPath: jsonURL.path) {
//            do {
//                let jsonData = try Data(contentsOf: jsonURL)
//                parents = try JSONDecoder().decode([Parent].self, from: jsonData)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
        // Markdown
        let markDownURL = URL.documentsDirectory.appending(path: "Family.md")
        if FileManager().fileExists(atPath: markDownURL.path) {
            do {
                let markdownString = try String(contentsOf: markDownURL)
                parents = try MarkDecoder().decode([Parent].self, from: markdownString)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
