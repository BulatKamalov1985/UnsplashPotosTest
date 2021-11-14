//
//  TabBarViewController.swift
//  UnsplashPotosTest
//
//  Created by Bulat Kamalov on 12.11.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar()
    }
    
    func setupTabBar() {
        
        let imagesCollectionVC = createNavController(vc: ImagesCollectionVC(), itemName: "Images", itemImage: "photo")
        let imagesTableVC = createNavController(vc: ImagesTableVC(), itemName: "Favorites", itemImage: "heart.rectangle")
        
        viewControllers = [imagesCollectionVC, imagesTableVC]
    }
    
    func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName,
                                image: UIImage(named: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)),
                                tag: 0)
        
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        
        return navController
    }
}

