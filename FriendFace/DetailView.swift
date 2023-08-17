//
//  DetailView.swift
//  FriendFace
//
//  Created by Alex Bonder on 8/16/23.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 20) {
                    ForEach(user.tags, id: \.self) { tag in
                        Text("#\(tag)")
                            .padding(4)
                            .background(.ultraThickMaterial)
                            .foregroundColor(.secondary)
                            .cornerRadius(5)
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 30)
            .scrollIndicators(.hidden)

            Form {
                Section("Age") {
                    Text(user.age, format: .number)
                }
                
                Section("Company") {
                    Text(user.company)
                }
                
                Section("Address") {
                    HStack {
                        Text("Home:")
                            .opacity(0.6)
                        Text(user.address)
                    }

                    HStack {
                        Text("email:")
                            .opacity(0.6)
                        Text(user.email)
                    }
                }
                
                Section("About") {
                    Text(user.about)
                }
                
                Section("Friends") {
                    List {
                        ForEach(user.friends) { friend in
                            Text(friend.name)
                        }
                    }
                }
                
                Text("Registered: \(user.registeredDisplayDate)")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
        
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                Text(user.isActive ? "🟢" : "⚫️")
                    .font(.caption)
                    .opacity(user.isActive ? 1 : 0.5)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(user: User(
                id: "50a48fa3-2c0f-4397-ac50-64da464f9954",
                isActive: false,
                name: "Alford Rodriguez",
                age: 21,
                company: "Imkan",
                email: "alfordrodriguez@imkan.com",
                address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
                about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
                registered: Date.now,
                tags: [
                    "cillum",
                    "consequat",
                    "deserunt",
                    "nostrud",
                    "eiusmod",
                    "minim",
                    "tempor"
                ], friends: [Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel")]
            ))
        }
    }
}
