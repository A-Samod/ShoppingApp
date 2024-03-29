//
//  CartModel.swift
//  ShoppingApp
//
//  Created by A Samod on 2024-03-27.
//

import Foundation

struct CartItem {
    let cartId: UUID
    let pid: Int
    let name: String
    let price: Double
    var quantity: Int
    let imageURL: String
    let size: String
    let eachPrice: String
}

var cartItems: [CartItem] = []
