//
//  ProfileMenuItemView.swift
//  DogWalk
//
//  Created by MacBook on 22.05.2026.
//

import UIKit

final class ProfileMenuItemView: UIView {
    
    
    
    // MARK: - UI Elements
    
    private let iconImageView: UIImageView = {
        let  imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.interRegular18()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView () {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = AppColor.surfase
        addSubview(iconImageView)
        addSubview(titleLabel)
        
        
        
        NSLayoutConstraint.activate([
            
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            heightAnchor.constraint(equalToConstant: 56)
            
        ])
        
    }
    
    // MARK: - Configure
    
    func configure (icon: UIImage?,title: String, iconTintColor: UIColor? = nil ) {
        iconImageView.image = icon
        titleLabel.text = title
        if let tint = iconTintColor {
            iconImageView.tintColor = tint
        }
    }
}
