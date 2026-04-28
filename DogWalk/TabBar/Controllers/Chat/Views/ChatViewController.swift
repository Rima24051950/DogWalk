//
//  ChatViewController.swift
//  DogWalk
//
//  Created by MacBook on 11.03.2026.
//
import UIKit



class ChatViewController: UIViewController {
    
    
    private var inputBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Data
    
    var chatItems: [ChatItem] = [
        .dateHeader("1 April 12:00"),
        .message(Message(text: "Hey, Alex! Nice to meet you! I’d like to hire a walker and you’re perfect one for me. Can you help me out?", isFromMe: true, date: Date())),
        .message(Message(text: "Hi! That’s great! Let me give you a call and we’ll discuss all the details", isFromMe: false, date: Date())),
        .dateHeader("12:30"),
        .message(Message(text: "Okay, I'm waiting for a call)", isFromMe: true, date: Date()))
    ]
    
    // MARK: - UI Elements - Table
    
    private let messagesTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.keyboardDismissMode = .onDrag
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - UI Elements - Input Container
    
    private let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = AppColor.disabled.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Aa"
        field.font = AppFont.interRegular18()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = AppColor.disabled
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let micButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        button.tintColor = AppColor.textDark
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - UI Elements - Header (отдельные элементы)
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Arrow - Left"), for: .normal)
        button.tintColor = AppColor.textColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let onlineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Alex Murray")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Alex Murray"
        label.textColor = AppColor.textColor
        label.font = AppFont.interSemibold18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let onlineLabel: UILabel = {
        let label = UILabel()
        label.text = "Online"
        label.textColor = AppColor.disabled
        label.font = AppFont.interRegular18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let onlineDot: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let callImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Call")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // ✅ Хедер: добавляем элементы по отдельности (как у вас работало)
        view.addSubview(backButton)
        view.addSubview(onlineImageView)
        view.addSubview(nameLabel)
        view.addSubview(onlineLabel)
        view.addSubview(onlineDot)
        view.addSubview(callImageView)
        
        // ✅ TableView и Input
        view.addSubview(messagesTableView)
        view.addSubview(inputContainerView)
        inputContainerView.addSubview(textField)
        inputContainerView.addSubview(plusButton)
        inputContainerView.addSubview(micButton)
        
        // ✅ Setup
        setupTableView()
        setupActions()
        setupConstraints()
        
        navigationItem.hidesBackButton = true
        
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.register(DateHeaderCell.self, forCellReuseIdentifier: "DateHeaderCell")
        messagesTableView.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func backTapped() {
        if let nav = navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
        } else if presentingViewController != nil {
            dismiss(animated: true)
        } else {
            tabBarController?.selectedIndex = 1
        }
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            // Back button
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            // Call button
            callImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            callImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            callImageView.widthAnchor.constraint(equalToConstant: 24),
            callImageView.heightAnchor.constraint(equalToConstant: 24),
            
            // Avatar
            onlineImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            onlineImageView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 12),
            onlineImageView.widthAnchor.constraint(equalToConstant: 48),
            onlineImageView.heightAnchor.constraint(equalToConstant: 48),
            
            // Name
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: onlineImageView.trailingAnchor, constant: 8),
            nameLabel.heightAnchor.constraint(equalToConstant: 26),
            
            // Online label (самый нижний элемент хедера!)
            onlineLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            onlineLabel.leadingAnchor.constraint(equalTo: onlineImageView.trailingAnchor, constant: 8),
            onlineLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // Online dot
            onlineDot.centerYAnchor.constraint(equalTo: onlineLabel.centerYAnchor),
            onlineDot.leadingAnchor.constraint(equalTo: onlineImageView.trailingAnchor, constant: 8),
            onlineDot.widthAnchor.constraint(equalToConstant: 6),
            onlineDot.heightAnchor.constraint(equalToConstant: 6),
            
            // ===== TABLEVIEW (привязан к самому нижнему элементу хедера) =====
            messagesTableView.topAnchor.constraint(equalTo: onlineLabel.bottomAnchor, constant: 16), // ✅ Ключевое!
            messagesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messagesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messagesTableView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
            
            // ===== INPUT CONTAINER =====
            inputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            inputContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            
            // Plus Button
            plusButton.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 12),
            plusButton.centerYAnchor.constraint(equalTo: inputContainerView.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            
            // TextField
            textField.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: micButton.leadingAnchor, constant: -8),
            textField.centerYAnchor.constraint(equalTo: inputContainerView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 36),
            
            // Mic Button
            micButton.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -12),
            micButton.centerYAnchor.constraint(equalTo: inputContainerView.centerYAnchor),
            micButton.widthAnchor.constraint(equalToConstant: 30),
            micButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        inputBottomConstraint = inputContainerView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
            inputBottomConstraint?.isActive = true
    }
    
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = chatItems[indexPath.row]
        
        switch item {
        case .dateHeader(let date):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateHeaderCell", for: indexPath) as! DateHeaderCell
            cell.configure(with: date)
            return cell
            
        case .message(let message):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
            cell.configure(with: message)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = chatItems[indexPath.row]
        
        switch item {
        case .dateHeader:
            return 40
        case .message:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if case .dateHeader = chatItems[indexPath.row] {
            cell.contentView.layoutMargins = .zero
        }
    }
}
