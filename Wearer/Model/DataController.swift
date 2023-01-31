//
//  DataController.swift
//  Wearer
//
//  Created by Alberto Mura on 20/01/23.
//

import Foundation
import CoreData
import UIKit

/// This class provides a singleton
/// to save an delete data on disk
class DataController {
    static let shared = DataController()
    let container = NSPersistentContainer(name: "ClothesDataModel")
    
    private init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    /// Save a cloth with this properties
    func saveCloth(picture: UIImage, type: String, color: String, warmness: Int) -> Cloth {
        let cloth = Cloth(context: container.viewContext)
        cloth.picture = picture.pngData()
        cloth.type = type
        cloth.color = color
        cloth.warmness = Int16(warmness)
        return cloth
    }
    
    /// Delete a cloth
    func delete(cloth: Cloth) {
        container.viewContext.delete(cloth)
    }
    
    /// Save context on disk, you have to call this
    /// function to confirm each disk modification
    func save() throws {
        try container.viewContext.save()
    }
}
