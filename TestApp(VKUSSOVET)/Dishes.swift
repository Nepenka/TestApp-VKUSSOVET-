//
//  Dishes.swift
//  TestApp(VKUSSOVET)
//
//  Created by 123 on 18.01.24.
//

import Foundation




struct Dishes: Codable {
    let status: Bool
    let dishesList: [DishesList]
}

struct DishesList: Codable {
    var id: String
    var image: String
    var name: String
    var content: String
    var price: String
    var weight: String
    var spicy: String
}
