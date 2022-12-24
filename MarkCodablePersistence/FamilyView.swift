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

struct FamilyView: View {
    @EnvironmentObject var store: DataStore
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.parents) { parent in
                    Section(header: HeaderView(parent: parent)) {
                        HStack {
                            Text("Children")
                            Button {
                                store.entity = .child(parent)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }
                            .foregroundColor(.accentColor)
                        }
                        ForEach(parent.children, id: \.self) { child in
                                Text(child)
                            .swipeActions {
                                Button(role: .destructive) {
                                    store.deleteChild(child: child, for: parent)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Families")
            .toolbar {
                ToolbarItem {
                    Button {
                        store.entity = .family
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(item: $store.entity) { $0.presentationDetents([.medium]) }
        }
        .padding()
    }
}

struct HeaderView: View {
    @EnvironmentObject var store: DataStore
    let parent: Parent
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(parent.firstName) \(parent.lastName)").font(.title)
                Button(role: .destructive) {
                    store.deleteFamily(parent: parent)
                } label: {
                    Image(systemName: "trash.circle.fill")
                }
            }
            Text("\(parent.address.city), \(parent.address.provState)")
        }
    }
}

struct FamilyView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyView()
            .environmentObject(DataStore())
    }
}
