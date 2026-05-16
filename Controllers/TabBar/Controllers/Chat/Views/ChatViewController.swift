//
//  ChatViewController.swift
//  DogWalk
//
//  Created by MacBook on 11.03.2026.
//
import UIKit

class ChatViewController: UIViewController {
    
    // MARK: - Properties
    
    private var inputBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Data
    
    var chatItems: [ChatItem] = [
        .dateHeader("1 April 12:00"),
        .message(Message(text: "Hey, Alex! Nice to meet you! I'd like to hire a walker and you're perfect one for me. Can you help me out?", isFromMe: true, date: Date())),
        .message(Message(text: "Hi! That's great! Let me give you a call and we'll discuss all the details", isFromMe: false, date: Date())),
        .dateHeader("12:30"),
        .message(Message(text: "Okay, I'm waiting for a call)", isFromMe: true, date: Date()))
    ]
    
    // MARK: - UI Elements - Table
    
    private let messagesTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
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
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 0.5
        view.layer.borderColor = AppColor.disabled.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Aa"
        field.font = AppFont.interRegular18()
        field.textColor = .label
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = AppColor.primary
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
    
    // MARK: - UI Elements - Header Container ✅ НОВОЕ
    
    private let headerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.font = UIFont(name: "Poppins-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
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
        view.backgroundColor = .systemGreen
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
        view.backgroundColor = .systemBackground
        
       
        view.addSubview(headerContainerView)
        
       
        headerContainerView.addSubview(backButton)
        headerContainerView.addSubview(onlineImageView)
        headerContainerView.addSubview(nameLabel)
        headerContainerView.addSubview(onlineLabel)
        headerContainerView.addSubview(onlineDot)
        headerContainerView.addSubview(callImageView)
        
       
        view.addSubview(messagesTableView)
        view.addSubview(inputContainerView)
        inputContainerView.addSubview(textField)
        inputContainerView.addSubview(plusButton)
        inputContainerView.addSubview(micButton)
        
        setupTableView()
        setupActions()
        setupConstraints()
        setupKeyboardNotifications()
        
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
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
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
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height - view.safeAreaInsets.bottom
        
        UIView.animate(withDuration: 0.3) {
            self.inputBottomConstraint?.isActive = false
            self.inputBottomConstraint = self.inputContainerView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor,
                constant: -keyboardHeight
            )
            self.inputBottomConstraint?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.inputBottomConstraint?.isActive = false
            self.inputBottomConstraint = self.inputContainerView.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor
            )
            self.inputBottomConstraint?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Constraints ✅ ИСПРАВЛЕНО
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
           
            headerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: -54),
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerContainerView.heightAnchor.constraint(equalToConstant: 60),
         
            
            // Back button
            backButton.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            // Call button
            callImageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 8),
            callImageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -16),
            callImageView.widthAnchor.constraint(equalToConstant: 24),
            callImageView.heightAnchor.constraint(equalToConstant: 24),
            
            // Avatar
            onlineImageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 6),
            onlineImageView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 12),
            onlineImageView.widthAnchor.constraint(equalToConstant: 48),
            onlineImageView.heightAnchor.constraint(equalToConstant: 48),
            
            // Name
            nameLabel.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: onlineImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: callImageView.leadingAnchor, constant: -8),
            
            // Online label
            onlineLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            onlineLabel.leadingAnchor.constraint(equalTo: onlineImageView.trailingAnchor, constant: 8),
            
            // Online dot
            onlineDot.centerYAnchor.constraint(equalTo: onlineLabel.centerYAnchor),
            onlineDot.leadingAnchor.constraint(equalTo: onlineLabel.trailingAnchor, constant: 4),
            onlineDot.widthAnchor.constraint(equalToConstant: 6),
            onlineDot.heightAnchor.constraint(equalToConstant: 6),
            
            //  TABLEVIEW
            messagesTableView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: 0),
            messagesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messagesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messagesTableView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
            
            
            inputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            inputContainerView.heightAnchor.constraint(equalToConstant: 56),
            
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
        
        // Инициализация ограничения для клавиатуры
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
