//
//  MessageCell.swift
//  DogWalk
//
//  Created by MacBook on 09.04.2026.
//

import UIKit

class MessageCell: UITableViewCell {
    
    private let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.interRegular18()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Констрайнт для позиционирования (слева/справа)
    private var bubbleLeadingConstraint: NSLayoutConstraint?
    private var bubbleTrailingConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        backgroundColor = .clear
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 280),
            
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -16),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with message: Message) {
        messageLabel.text = message.text
        
        if message.isFromMe {
            // ✅ Моё сообщение (оранжевое, справа)
            bubbleView.backgroundColor = UIColor(red: 1.0, green: 0.45, blue: 0.35, alpha: 1.0) // Оранжевый как в макете
            messageLabel.textColor = .white
            alignToRight()
        } else {
            // ✅ Сообщение собеседника (серое, слева)
            bubbleView.backgroundColor = UIColor.systemGray5
            messageLabel.textColor = .black
            alignToLeft()
        }
    }
    
    private func alignToRight() {
        bubbleLeadingConstraint?.isActive = false
        bubbleTrailingConstraint?.isActive = false
        
        bubbleTrailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        bubbleLeadingConstraint = bubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 80)
        
        bubbleTrailingConstraint?.isActive = true
        bubbleLeadingConstraint?.isActive = true
    }
    
    private func alignToLeft() {
        bubbleLeadingConstraint?.isActive = false
        bubbleTrailingConstraint?.isActive = false
        
        bubbleLeadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        bubbleTrailingConstraint = bubbleView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -80)
        
        bubbleLeadingConstraint?.isActive = true
        bubbleTrailingConstraint?.isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Сброс констрайнтов
        bubbleLeadingConstraint?.isActive = false
        bubbleTrailingConstraint?.isActive = false
    }
}
