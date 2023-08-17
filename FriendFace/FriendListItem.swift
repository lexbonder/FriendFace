//
//  FriendListItem.swift
//  FriendFace
//
//  Created by Alex Bonder on 8/16/23.
//

import SwiftUI

struct FriendListItem: View {
    let name: String
    let isActive: Bool
    
    var body: some View {
        HStack{
            Text(isActive ? "🟢" : "⚫️")
                .font(.caption)
                .opacity(isActive ? 1 : 0.5)
            Text(name)
        }
    }
}

struct FriendListItem_Previews: PreviewProvider {
    static var previews: some View {
        FriendListItem(name: "Timothy Goose", isActive: true)
    }
}
