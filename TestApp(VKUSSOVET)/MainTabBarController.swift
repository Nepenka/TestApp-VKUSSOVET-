//
//  MainTabBarController.swift
//  TestApp(VKUSSOVET)
//
//  Created by 123 on 16.01.24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarApperance()
    }
    
    private  func generateTabBar() {
      viewControllers = [
      generateVC(viewController: ViewController(), title: "", image: UIImage(systemName: "list.bullet")),
      generateVC(viewController: ShopingCartController(), title: "", image: UIImage(systemName: "cart")),
      generateVC(viewController: InformationController(), title: "", image: UIImage(systemName: "info"))
      ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarApperance() {
        tabBar.layer.borderColor = UIColor.red.cgColor
    }

}
