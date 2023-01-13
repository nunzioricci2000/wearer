//
//  Cloth.swift
//  Wearer
//
//  Created by Alberto Mura on 13/01/23.
//

import Foundation

struct Cloth: Identifiable {
    var name : String
    var type : ClothType
    var picture : String
    var id = UUID()
}

enum ClothType: String {
    case shirt = "Shirts"
    case jeans = "Jeans"
    case shoes = "Shoes"
    case jacket = "Jackets"
}
