//
//  ChatListCell.swift
//  DogWalk
//
//  Created by MacBook on 23.04.2026.
//

import UIKit

final class ChatListCell: UITableViewCell {
    
    static let identifier = "ChatListCell"
    
    // MARK: - UI Elements
    
    private let avatarContainer: UIView = {
        UIView.makeView()
    }()
    
    private let nameLabel: UILabel = {
        UILabel.makeLabel(
            font: UIFont.boldSystemFont(ofSize: 20),
            textColor: .label
        )
    }()
    
    private let messageLabel: UILabel = {
        UILabel.makeLabel(
            font: UIFont.systemFont(ofSize: 17),
            textColor: AppColor.textDark,
            numberOfLines: 2
        )
    }()
    
    private let timeLabel: UILabel = {
        UILabel.makeTime("")
    }()
    
    private let unreadDot: UIView = {
        let dot = UIView.makeView(backgroundColor: .systemOrange, cornerRadius: 5)
        dot.isHidden = true
        return dot
    }()
    
    private let separatorView: UIView = {
        UIView.makeSeparatorView()
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(avatarContainer)
        contentView.addSubview(nameLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(unreadDot)
        contentView.addSubview(separatorView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Avatar
            avatarContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarContainer.widthAnchor.constraint(equalToConstant: 56),
            avatarContainer.heightAnchor.constraint(equalToConstant: 56),
            
            // Name
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: avatarContainer.trailingAnchor, constant: 14),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: timeLabel.leadingAnchor, constant: -8),
            
            // Message
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            messageLabel.leadingAnchor.constraint(equalTo: avatarContainer.trailingAnchor, constant: 14),
            messageLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            // Time
            timeLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Unread dot
            unreadDot.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -12),
            unreadDot.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            unreadDot.widthAnchor.constraint(equalToConstant: 10),
            unreadDot.heightAnchor.constraint(equalToConstant: 10),
            
            // Separator
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 86),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with item: ChatListItem) {
        // Avatar
        avatarContainer.subviews.forEach { $0.removeFromSuperview() }
        let avatar = UIImageView.makeAvatar(
            imageName: item.avatarName,
            size: 56,
            showOnlineDot: item.isOnline
        )
        avatarContainer.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: avatarContainer.topAnchor),
            avatar.leadingAnchor.constraint(equalTo: avatarContainer.leadingAnchor),
            avatar.trailingAnchor.constraint(equalTo: avatarContainer.trailingAnchor),
            avatar.bottomAnchor.constraint(equalTo: avatarContainer.bottomAnchor)
        ])
        
        // Text
        nameLabel.text = item.name
        messageLabel.text = item.lastMessage
    
        unreadDot.isHidden = !item.hasUnread
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        messageLabel.text = nil
        timeLabel.text = nil
        unreadDot.isHidden = true
    }
}
