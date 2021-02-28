//
//  CustomTabBarcontroller.swift
//  messenger
//
//  Created by HieuTong on 2/26/21.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up custom view controllers
        let layout = UICollectionViewFlowLayout()
        let friendController = FriendController(collectionViewLayout: layout)
        let recentMessageNavController = UINavigationController(rootViewController: friendController)
        recentMessageNavController.tabBarItem.title = "Recent"
        recentMessageNavController.tabBarItem.image = UIImage(named: "recent")
        
//        let viewController = UIViewController()
//        let navController = UINavigationController(rootViewController: viewController)
//        navController.tabBarItem.title = "Calls"
//        navController.tabBarItem.image = UIImage(named: "calls")
        
        

        viewControllers = [recentMessageNavController, createDummyNavControllerWithTitle(title: "Calls", imageName: "calls"), createDummyNavControllerWithTitle(title: "People", imageName: "people"), createDummyNavControllerWithTitle(title: "Setting", imageName: "settings")]
    }
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}

