//
//  Networking.swift
//  TestingApp(Vkussovet)
//
//  Created by 123 on 15.01.24.
//

import UIKit
import Alamofire


class Networking {

    let apiEndpoint = "https://vkus-sovet.ru/api/getMenu.php"
    var menuItems: [MenuItem] = []
    var completionHandler: (() -> Void)?

    func fetchData(completion: @escaping () -> Void) {
        self.completionHandler = completion

        AF.request(apiEndpoint).responseDecodable(of: Menu.self) { [weak self] response in
            guard let self = self else { return }

            switch response.result {
            case .success(let menu):
                print(menu.status)
                self.menuItems = menu.menuList
                self.completionHandler?()

            case .failure(let error):
                print("Error making request: \(error)")
            }
        }
    }
}
