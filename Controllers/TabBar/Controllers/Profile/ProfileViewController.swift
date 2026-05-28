//
//  ProfileViewController.swift
//  DogWalk
//
//  Created by MacBook on 09.03.2026.


import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.surfase
        view.layer.cornerRadius = 22
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = AppColor.backgroundInput
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()

    private let notificationsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = AppColor.backgroundInput
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    private let imageProfile:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "Ahmed")
        image.layer.cornerRadius = 82.5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
 
        
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cristian Downey"
        label.font = UIFont(name: "Poppins-Bold", size: 34)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let editIconButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = AppColor.textDark
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    private let locationName: UILabel = {
        let label = UILabel()
        label.text = "Moscow, Russia"
        label.font = AppFont.interRegular18()
        label.textColor = AppColor.disabled
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon")
        imageView.tintColor = AppColor.disabled
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    
    
    private let petsMenuItem = ProfileMenuItemView()
    private let favouritesMenuItem = ProfileMenuItemView()
    private let badgesMenuItem = ProfileMenuItemView()
    private let walletMenuItem = ProfileMenuItemView()
    
    
    
    private let viewAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View all", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = AppFont.interRegular18()
        button.setTitle("View all \u{2192}", for: .normal)
        // Стилизация по ТЗ
        button.backgroundColor = .black
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
       
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    
    
    private func setupMenuItems () {
        
        petsMenuItem.configure(icon:
                                UIImage(named: "guide"),
                             title: "My pets")
        
        favouritesMenuItem.configure(icon: UIImage(named: "lover"), title: "My favourites")
        
        
        badgesMenuItem.configure(icon: UIImage(named: "medal"), title: "My badges")
        
        walletMenuItem.configure(icon: UIImage(named: "dollar"), title: "My wallet")
                        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupMenuItems()
        // 🔥 Кнопка "View all" → переход на оплату
        viewAllButton.addTarget(self, action: #selector(viewAllTapped), for: .touchUpInside)
        viewAllButton.isUserInteractionEnabled = true // На всякий случай
        
    }
    
    
    private func setupView() {
        view.backgroundColor = .white
    
        
        view.addSubview(containerView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(settingsButton)
        containerView.addSubview(notificationsButton)
        
        
        view.addSubview(imageProfile)
        view.addSubview(nameLabel)
        view.addSubview(editIconButton)
     
        view.addSubview(locationStack)
        locationStack.addArrangedSubview(locationIcon)
        locationStack.addArrangedSubview(locationName)
        
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(petsMenuItem)
        contentView.addSubview(favouritesMenuItem)
        contentView.addSubview(badgesMenuItem)
        contentView.addSubview(walletMenuItem)
        contentView.addSubview(viewAllButton)
        
    
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                // ContentView привязан к scrollView
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                
                // ВАЖНО: ширина contentView = ширина view (для вертикального скролла)
                contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
        
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
           containerView.heightAnchor.constraint(equalToConstant: 58),
            containerView.widthAnchor.constraint(equalToConstant: 343),
            
            
            settingsButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            settingsButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            settingsButton.heightAnchor.constraint(equalToConstant: 44),
            settingsButton.widthAnchor.constraint(equalToConstant: 44),
            
            
            notificationsButton.trailingAnchor.constraint(equalTo:containerView.trailingAnchor, constant: -16),
            notificationsButton.centerYAnchor.constraint(equalTo:containerView.centerYAnchor),
            notificationsButton.widthAnchor.constraint(equalToConstant: 44),
            notificationsButton.heightAnchor.constraint(equalToConstant: 44),
            
            
            imageProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageProfile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageProfile.widthAnchor.constraint(equalToConstant: 165),
            imageProfile.heightAnchor.constraint(equalToConstant: 165),
            
            
            
         
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 190),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            nameLabel.widthAnchor.constraint(equalToConstant: 301),
            nameLabel.heightAnchor.constraint(equalToConstant: 51),
            
            
         
            editIconButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20),
            editIconButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            editIconButton.widthAnchor.constraint(equalToConstant: 24),
            editIconButton.heightAnchor.constraint(equalToConstant: 24),
            
            
            locationName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            locationName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 111),
            locationName.widthAnchor.constraint(equalToConstant: 153),
            
            
            locationStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            locationStack.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            locationStack.heightAnchor.constraint(equalToConstant: 24),
            
            locationIcon.widthAnchor.constraint(equalToConstant: 17),
            locationIcon.heightAnchor.constraint(equalToConstant: 17),
            
          

            // Отступ от locationStack
            petsMenuItem.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 8),
            petsMenuItem.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            petsMenuItem.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            favouritesMenuItem.topAnchor.constraint(equalTo: petsMenuItem.bottomAnchor, constant: 19),
            favouritesMenuItem.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favouritesMenuItem.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            badgesMenuItem.topAnchor.constraint(equalTo: favouritesMenuItem.bottomAnchor, constant: 19),
            badgesMenuItem.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            badgesMenuItem.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            walletMenuItem.topAnchor.constraint(equalTo: badgesMenuItem.bottomAnchor, constant: 19),
            walletMenuItem.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            walletMenuItem.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewAllButton.topAnchor.constraint(equalTo: walletMenuItem.bottomAnchor, constant: 22),
            viewAllButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            viewAllButton.widthAnchor.constraint(equalToConstant: 343),
            viewAllButton.heightAnchor.constraint(equalToConstant: 58),
            viewAllButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
                ])
            }
            
    @objc private func viewAllTapped() {
        print("🔘 View all нажата! Переход на Payment...") // Проверка в консоли
        
        // 🎯 Создаём экран оплаты
        let paymentVC = PaymentViewController()
        paymentVC.hidesBottomBarWhenPushed = true // Скрываем таббар на экране оплаты
        
        // 🚀 Переход
        if let nav = navigationController {
            nav.pushViewController(paymentVC, animated: true)
        } else {
            // Запасной вариант: модальное окно
            paymentVC.modalPresentationStyle = .pageSheet
            present(paymentVC, animated: true)
        }
    }
            
        
    }
    
    
    
    
 
    
    

