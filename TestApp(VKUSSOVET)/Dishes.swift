//
//  Dishes.swift
//  TestApp(VKUSSOVET)
//
//  Created by 123 on 18.01.24.
//

import Foundation

struct Dishes: Codable {
    let status: Bool
    let menuList: [Dish]
}

struct Dish: Codable {
    let id: String
    var image: String
    let name: String
    let content: String
    let price: String
    let weight: String
    let spicy: String?
}
