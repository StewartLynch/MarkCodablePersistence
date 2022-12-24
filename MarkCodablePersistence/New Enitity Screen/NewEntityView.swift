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

struct NewEntityView: View {
    @EnvironmentObject var store: DataStore
    @Environment(\.dismiss) var dismiss
    var parent: Parent?
    var newParent: Bool {
        parent == nil
    }

    // Form Fields
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var city = ""
    @State private var provState = ""
    @State private var age = ""
    var isDisabled: Bool {
        if newParent {
            return [firstName, lastName, city, provState]
                .map {!$0.isEmpty}
                .filter {$0 == false}
                .count > 0

        } else {
            return firstName.isEmpty
        }
    }
    var body: some View {
        NavigationStack {
            Form {
                TextField("\(newParent ? "First Name" : "Name")", text: $firstName)
                if newParent {
                    TextField("Last Name", text: $lastName)
                    TextField("City", text: $city)
                    TextField("Prov/State", text: $provState)
                }
                HStack {
                    Spacer()
                    Button("Add") {
                        if newParent {
                            store.addFamily(parent: Parent(firstName: firstName,
                                                           lastName: lastName,
                                                           address: Address(city: city,
                                                                                   provState: provState)))
                        } else {
                            if let parent {
                                store.addChild(firstName, for: parent)
                            }
                        }
                        dismiss()
                    }
                    .disabled(isDisabled)
                    .buttonStyle(.borderedProminent)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            .navigationTitle(newParent ? "New Parent" : "New Child")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
        }
    }
}

struct NewEntityView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntityView()
    }
}
