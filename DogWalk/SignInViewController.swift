//
//  SignInViewController.swift
//  DogWalk
//
//  Created by MacBook on 11.03.2026.
//

import UIKit

final class SignInViewController: UIViewController {
    

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            navigationController?.setNavigationBarHidden(false, animated: animated)
            
            showGuestModeHint()
            
            // ✅ Настройка заголовка
            title = "Экран без регистрации"
            view.backgroundColor = AppColor.secondary
        }
    
    private func showGuestModeHint() {
        let alert = UIAlertController(
            title: "👋 Привет!",
            message: "Вы можете исследовать приложение без регистрации. Для сохранения данных войдите в аккаунт позже.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Понял", style: .default))
        present(alert, animated: true)
    }
        
    }
