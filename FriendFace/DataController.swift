//
//  DataController.swift
//  FriendFace
//
//  Created by Alex Bonder on 8/18/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FriendFaceData")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading data: \(error.localizedDescription)")
            }
        }
        
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
