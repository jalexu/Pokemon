//
//  CoreDataManager.swift
//  Pokemon
//
//  Created by Jaime Uribe on 24/01/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private let container : NSPersistentContainer!
    
    init() {
        container = NSPersistentContainer(name: "Pokemon")
        setupDatabase()
    }
    
    private func setupDatabase() {
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error loading store \(desc) — \(error)")
                return
            }
            print("Database ready!")
        }
    }
}
