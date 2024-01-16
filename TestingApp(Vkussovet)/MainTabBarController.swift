//
//  MainTabBarController.swift
//  TestingApp(Vkussovet)
//
//  Created by 123 on 16.01.24.
//

import UIKit

class MainTabBarController: UIViewController {
    
    let firstVc = ViewController()
    let secondVc = ShopingCartController()
    let thirdVc = InformationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstVc.tabBarItem = UITabBarItem(title: "First" , image: UIImage(named: "list.bullet"), selectedImage: nil)
        secondVc.tabBarItem = UITabBarItem(title: "Second", image: UIImage(named: "cart"), selectedImage: nil)
        thirdVc.tabBarItem = UITabBarItem(title: "Third", image: UIImage(named: "info"), selectedImage: nil)
        
    }
    

}
