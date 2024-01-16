//
//  Menu.swift
//  TestApp(VKUSSOVET)
//
//  Created by 123 on 16.01.24.
//

import Foundation
import UIKit


struct Menu: Codable {
    let status: Bool
    let menuList: [MenuItem]
}

struct MenuItem: Codable {
    let menuID: String
    let image: String
    let name: String
    let subMenuCount: Int
}
