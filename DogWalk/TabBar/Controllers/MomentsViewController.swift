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
    
    //  Сильная ссылка на hosting controller (важно!)
    private var hostingController: UIHostingController<MomentsView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Настройка навбара (опционально)
        title = "Moments"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        //  Встраиваем SwiftUI View
        embedSwiftUIMomentsView()
    }
    
    private func embedSwiftUIMomentsView() {
        // 1. Создаём SwiftUI View
        let momentsView = MomentsView()
        
        // 2. Создаём UIHostingController
        let hostingController = UIHostingController(rootView: momentsView)
        self.hostingController = hostingController  //  Сохраняем ссылку!
        
        // 3. Настраиваем внешний вид
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // 4. Добавляем как child view controller
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        // 5. Констрейнты на весь экран
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 6. Завершаем добавление child
        hostingController.didMove(toParent: self)
    }
    
    //  Очистка при удалении (опционально, но рекомендуется)
    deinit {
        hostingController?.willMove(toParent: nil)
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()
    }
}
