//
//  StoryAvatarCell.swift
//  DogWalk
//
//  Created by MacBook on 10.05.2026.
//

import UIKit

final class StoryAvatarCell: UICollectionViewCell  {
    
    // MARK: - Идентификатор
    
    static let identifier = "StoryAvatarCell"
    
    // MARK: - UI Elements
    
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = AppColor.primary.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 10)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        
        setupConstraints()
        
    }
    
    private func  setupConstraints(){
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 64),
            avatarImageView.heightAnchor.constraint(equalToConstant: 64),
            
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        avatarImageView.layer.cornerRadius = 32
    }
    
    func configure (with avatar: AvatarModel,isNew:Bool) {
        avatarImageView.image = avatar.image
        nameLabel.text = avatar.name
        if isNew {
            avatarImageView.backgroundColor = AppColor.primary
            avatarImageView.tintColor = .white
            
         
            let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .light, scale: .small)
            let plusImage = UIImage(systemName: "plus", withConfiguration: config)
            avatarImageView.image = plusImage?.withRenderingMode(.alwaysTemplate)
            
          
            avatarImageView.contentMode = .scaleAspectFit
        } else {
            avatarImageView.backgroundColor = .clear
            avatarImageView.tintColor = nil
            avatarImageView.image = avatar.image?.withRenderingMode(.alwaysOriginal)
            avatarImageView.contentMode = .scaleAspectFill // Фото заполняет круг
        }
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
