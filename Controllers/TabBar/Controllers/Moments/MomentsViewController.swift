//
//  MomentsViewController.swift
//  DogWalk
//
//  Created by MacBook on 14.03.2026.
//

// MomentsViewController.swift
import UIKit
import SwiftUI

class MomentsViewController: UIViewController {
    
    private var hostingController: UIHostingController<MomentsView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Moments"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        embedSwiftUIMomentsView()
      
    }
    
    private func embedSwiftUIMomentsView() {
       
        let momentsView = MomentsView { [weak self] in  // ✅ ВОТ ЭТОГО НЕ ХВАТАЛО!
            self?.navigateToChat()
        }
        
        // 2. Создаём UIHostingController
        let hostingController = UIHostingController(rootView: momentsView)
        self.hostingController = hostingController
        
        // 3. Настраиваем внешний вид
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // 4. Добавляем как child
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        // 5. Констрейнты
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 6. Завершаем
        hostingController.didMove(toParent: self)
    }
    
    //  перехода на Chat
    private func navigateToChat() {
        print(" Navigating to Chat...")
        
        let chatVC = ChatViewController()
        chatVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    deinit {
        hostingController?.willMove(toParent: nil)
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()
    }
}
