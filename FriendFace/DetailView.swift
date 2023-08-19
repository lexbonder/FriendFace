//
//  DetailView.swift
//  FriendFace
//
//  Created by Alex Bonder on 8/16/23.
//

import SwiftUI

struct DetailView: View {
    let user: CachedUser
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 20) {
                    ForEach(user.wrappedTags, id: \.self) { tag in
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
                    Text(user.wrappedCompany)
                }
                
                Section("Address") {
                    HStack {
                        Text("Home:")
                            .opacity(0.6)
                        Text(user.wrappedAddress)
                    }

                    HStack {
                        Text("email:")
                            .opacity(0.6)
                        Text(user.wrappedEmail)
                    }
                }
                
                Section("About") {
                    Text(user.wrappedAbout)
                }
                
                Section("Friends") {
                    List {
                        ForEach(user.wrappedFriends) { friend in
                            Text(friend.wrappedName)
                        }
                    }
                }
                
                Text("Registered: \(user.registeredDate)")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
        
        .navigationTitle(user.wrappedName)
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
