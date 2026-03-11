//
//  ProfileViewController.swift
//  DogWalk
//
//  Created by MacBook on 09.03.2026.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        // ✅ Настройка заголовка
        title = "profile"
        view.backgroundColor = AppColor.surfase
    }
    
}
