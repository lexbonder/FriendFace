//
//  ContentView.swift
//  FriendFace
//
//  Created by Alex Bonder on 8/16/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var cachedUsers: FetchedResults<CachedUser>
    @FetchRequest(sortDescriptors: []) var cachedFriends: FetchedResults<CachedFriend>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cachedUsers) { user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        FriendListItem(name: user.wrappedName, isActive: user.isActive)
                    }
                }
                .onDelete(perform: deleteUser)
            }
            .navigationTitle("FriendFace")
            .toolbar {
                Button("Wipe Data") {
                    for friend in cachedFriends {
                        moc.delete(friend)
                    }
                    for user in cachedUsers {
                        moc.delete(user)
                    }
                    
                    try? moc.save()
                }
                .foregroundColor(.red)
                EditButton()
            }
        }
        .task {
            if cachedUsers.count == 0 {
                await loadUsers()
            }
        }
    }
    
    func deleteUser(at offsets: IndexSet) {
        for index in offsets {
            let user = cachedUsers[index]
            moc.delete(user)
            try? moc.save()
        }
    }
    
    func loadUsers() async {
        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let loadedUsers = try decoder.decode([User].self, from: data)
            
            await MainActor.run {
                for user in loadedUsers {
                    let newUser = CachedUser(context: moc)
                    newUser.id = user.id
                    newUser.name = user.name
                    newUser.isActive = user.isActive
                    newUser.age = Int16(user.age)
                    newUser.company = user.company
                    newUser.email = user.email
                    newUser.address = user.address
                    newUser.about = user.about
                    newUser.registered = user.registered
                    newUser.tags = user.tags.joined(separator: ",")
                    
                    for friend in user.friends {
                        let newFriend = CachedFriend(context: moc)
                        newFriend.name = friend.name
                        newFriend.id = friend.id
                        newFriend.user = newUser
                    }
                    
                    try? moc.save()
                }
            }
        } catch {
            print("Users failed to load. Error: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
