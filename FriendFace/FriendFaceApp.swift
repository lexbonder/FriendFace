//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Alex Bonder on 8/16/23.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
