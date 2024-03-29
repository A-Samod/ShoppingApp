//
//  ProductModel.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-27.
//

import Foundation

struct ProductResponse: Codable {
    let data: [Product]
    let success: Bool
    let message: String
}
// Model
struct Product: Codable, Identifiable {
    let id: Int
    let name, description, price, category: String
    let size, color: String
    let image: String
    let quantity: Int
   // let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, description, price, category, size, color, image, quantity
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
    }
}
