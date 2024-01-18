//
//  Networking.swift
//  TestApp(VKUSSOVET)
//
//  Created by 123 on 16.01.24.
//

import UIKit
import Alamofire


class Networking {
    
    let apiEndpoint = "https://vkus-sovet.ru/api/getMenu.php"
    let apiEndpoint2 = "https://vkus-sovet.ru/api/getSubMenu.php"
    var menuItems: [MenuItem] = []
    var dishesList: [DishesList] = []
    var completionHandler: (() -> Void)?
    
    func fetchData() {
        AF.request(apiEndpoint).responseDecodable(of: Menu.self) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let menu):
                print(menu.status)
                self.menuItems = menu.menuList
                
                let baseURL = "https://vkus-sovet.ru"
                self.menuItems = self.menuItems.map { menuItem in
                    var updatedMenuItem = menuItem
                    updatedMenuItem.image = baseURL + menuItem.image
                    return updatedMenuItem
                }

                self.completionHandler?()
                
            case .failure(let error):
                print("Error making request: \(error)")
                self.menuItems = []
                self.completionHandler?()
            }
        }
    }
    
    
    func fetchDataForAnotherCollectionView() {
        AF.request(apiEndpoint2).responseDecodable(of: Dishes.self) { [weak self] response in
            guard let self = self else {return}
            
            switch response.result {
            case .success(let dishes):
                print(dishes.status)
                self.dishesList = dishes.dishesList
                
                let baseURL = "https://vkus-sovet.ru"
                self.dishesList = self.dishesList.map { dishesLists in
                    var updateDishesList = dishesLists
                    updateDishesList.image = baseURL + dishesLists.image
                    return updateDishesList
                }
                
                self.completionHandler?()
                
            case .failure(let error):
                print("Error making request: \(error)")
                self.dishesList = []
                self.completionHandler?()
            }
            
        }
    }
}
