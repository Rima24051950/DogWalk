//
//  HomeViewController.swift
//  DogWalk
//
//  Created by MacBook on 14.03.2026.
//


import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search..."
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "HOME"
        label.font = AppFont.interBold24()
        label.textColor = AppColor.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore dog walkers"
        label.font = AppFont.interRegular18()
        label.textColor = AppColor.disabled
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 10)
        
        button.tintColor = AppColor.onSurfase
        button.setTitle("Book a walk",for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 14)
        button.backgroundColor = AppColor.primary
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.backgroundInput
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        view.backgroundColor = .white
        
       
        view.addSubview(containerView)
        containerView.addSubview(contentStack)
        containerView.addSubview(iconButton)  
        view.addSubview(searchBar)
        
        setupConstraints()
        setupActions()
        
        searchBar.delegate = self
    }
    
    // MARK: - Constraints ✅ ВСЕ КОНСТРЕЙНТЫ ЗДЕСЬ
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //  containerView
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 77),
            
            //  contentStack (текст внутри контейнера)
            contentStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            //  iconButton (иконка справа внутри контейнера)
            iconButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            iconButton.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 200),
            iconButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconButton.widthAnchor.constraint(equalToConstant: 104),
            iconButton.heightAnchor.constraint(equalToConstant: 41),
            
            //  searchBar (под контейнером)
            searchBar.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 42)
            
        ])
    }
    
    // MARK: - Actions
    
    private func setupActions() {
        iconButton.addTarget(self, action: #selector(iconTapped), for: .touchUpInside)
    }
    
    @objc private func iconTapped() {
        print("➕ Icon tapped!")
    }
}

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("🔍 Search: \(searchBar.text ?? "")")
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
