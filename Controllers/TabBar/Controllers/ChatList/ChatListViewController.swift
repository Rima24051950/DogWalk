//
//  ChatListViewController.swift
//  DogWalk
//
//  Created by MacBook on 21.04.2026.
//

import UIKit

final class ChatListViewController: UIViewController {
    
    // MARK: - Data
    
    private var chatItems: [ChatListItem] = []
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        UILabel.makeTitle("Chat")
    }()
    
    private let searchField: UITextField = {
        UITextField.makeSearchField()
    }()
    
    private let titleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.rowHeight = 88
        table.contentInsetAdjustmentBehavior = .never
        table.contentInset = .zero
        
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
        setupTableView()
        view.addSubview(titleContainer)
        titleContainer.addSubview(titleLabel)
        setupConstraints()
        
        
    }
    
    // MARK: - Setup
    
    private func setupData() {
        chatItems = ChatListItem.mockData
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(searchField)
        view.addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatListCell.self, forCellReuseIdentifier: ChatListCell.identifier)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // ===== TITLE CONTAINER =====
            titleContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -48),
            titleContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           // titleContainer.heightAnchor.constraint(equalToConstant: 74),
            
            // ===== TitleLabel внутри container (с padding) =====
            titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -18),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -8),
            
            // ===== SEARCH FIELD ✅ ИСПРАВЛЕНО =====
            // ❌ БЫЛО: searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
            // ✅ СТАЛО: привязка к контейнеру!
            searchField.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 0), // Или 16, если нужен отступ
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchField.heightAnchor.constraint(equalToConstant: 44),
            
            // ===== TABLE VIEW =====
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Navigation
    
    private func openChat(with item: ChatListItem) {
        let chatVC = ChatViewController()
        chatVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(chatVC, animated: true)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = chatItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.identifier, for: indexPath) as! ChatListCell
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = chatItems[indexPath.row]
        openChat(with: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
}
