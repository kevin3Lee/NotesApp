//
//  RootTabBarController.swift
//  Notes
//
//  Created by Max Nelson on 3/15/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit


class RootTabBarController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UITabBar.appearance().backgroundImage = getImageWithColor(color: UIColor.blue.withAlphaComponent(0.5), size: CGSize(width: 10, height: 100))
//                UITabBar.appearance().tintColor = UIColor.init(red: 232/255, green: 206/255, blue: 126/255, alpha: 1).withAlphaComponent(0.5)
//        UITabBar.appearance().shadowImage =
        
        setupNavControllers()
    
    }
    
    fileprivate func setupNavControllers() {
        let foldersController = FoldersController()
        foldersController.navigationItem.title = "Folders"
        foldersController.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil), animated: false)
//        self.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)

        
        let nav = UINavigationController(rootViewController: foldersController)

        viewControllers = [
            nav
        ]

    }
    

}
