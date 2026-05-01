//
//  HomeViewController.swift
//  DogWalk
//
//  Created by MacBook on 11.03.2026.

import UIKit

class MainTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = AppColor.backgroundInput
        tabBar.unselectedItemTintColor = .systemGray
        
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = false
    
        
    }
    
    private func setupViewControllers() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        
        let momentsVC = MomentsViewController()
        momentsVC.tabBarItem = UITabBarItem(title: "Moments", image: UIImage(systemName: "photo.on.rectangle.fill"), tag: 2)
        
        let chatVC = ChatListViewController()
       // navigationController?.pushViewController(chatVC, animated: true)
        chatVC.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "message.fill"), tag: 3)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 4)
        
        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: momentsVC),
            UINavigationController(rootViewController: chatVC),
            UINavigationController(rootViewController: profileVC)
        ]
    }
}
