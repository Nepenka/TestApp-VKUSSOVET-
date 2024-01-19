
//Networking...


import UIKit
import Alamofire

class Networking {
    let apiEndpoint = "https://vkus-sovet.ru/api/getMenu.php"
    let apiEndpoint2 = "https://vkus-sovet.ru/api/getSubMenu.php"
    var menuItems: [MenuItem] = []
    var dishesList: [Dish] = []
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
    
    func fetchDataByIdAlamofire(menuID: String, completion: @escaping () -> Void) {
        let parameters: [String: String] = ["menuID": menuID]
        
        AF.request(apiEndpoint2, method: .post, parameters: parameters).responseJSON { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let data):
                guard let jsonData = try? JSONSerialization.data(withJSONObject: data),
                      let dishes = try? JSONDecoder().decode(Dishes.self, from: jsonData) else {
                    print("Ошибка при декодировании данных")
                    completion()
                    return
                }
                
                print(dishes.status)
                
                var updatedDishesList = dishes.menuList
                
                let baseURL = "https://vkus-sovet.ru"
                updatedDishesList = updatedDishesList.map { dish in
                    var updatedDish = dish
                    updatedDish.image = baseURL + dish.image
                    return updatedDish
                }
                
                self.dishesList = updatedDishesList
                
                completion()
                
            case .failure(let error):
                print("Ошибка при запросе данных: \(error.localizedDescription)")
                completion()
            }
        }
    }

}
