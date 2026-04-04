//
//  WalkerCardView.swift
//  DogWalk
//
//  Created by MacBook on 25.03.2026.
//

import UIKit
import SwiftUI



final class WalkerCardView: UIView {
    
    // MARK: - UI Elements
    
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let ratingBadge: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.primary
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private let starIcon: UIImageView = {
      let icon = UIImageView(image: UIImage(named: "rating"))
        icon.tintColor = AppColor.surfase
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
        
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13,weight: .regular)
        label.textColor = AppColor.textColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.interSemibold18()
        label.textColor = AppColor.textColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let priceBadge: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.textDark
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.alpha = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
        
    }()
    
    private let dollarSign: UILabel = {
        let label = UILabel()
        label.text = "$"
        label.font = UIFont.systemFont(ofSize: 9,weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
       label.text = "5/hr"
        label.font = UIFont.systemFont(ofSize: 8,weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    
    private let locationIcon: UIImageView = {
        //let imageView = UIImageView()
        let icon = UIImageView(image: UIImage(named: "icon"))
        icon.tintColor = AppColor.textColor
        icon.contentMode = .scaleAspectFit
        icon.alpha = 1.0
        icon.transform = .identity
        icon.layer.borderWidth = 1
        icon.layer.borderColor = AppColor.textSecondary.cgColor
        icon.layer.cornerRadius = 3
        icon.clipsToBounds = true
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    
    
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13,weight: .regular)
        label.textColor = AppColor.disabled
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    
    
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(cardImageView)
        addSubview(ratingBadge)
        ratingBadge.addSubview(starIcon)
        ratingBadge.addSubview(ratingLabel)
        
        
        addSubview(priceBadge)
        priceBadge.addSubview(dollarSign)
        priceBadge.addSubview(priceLabel)
        
        
        addSubview(nameLabel)
        addSubview(locationLabel)
        addSubview(locationIcon)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // 🔷 Картинка (квадратная)
            cardImageView.topAnchor.constraint(equalTo: topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardImageView.widthAnchor.constraint(equalToConstant: 179),  // ✅ width: 179
                    cardImageView.heightAnchor.constraint(equalToConstant: 125),
            
            // 🔷 Рейтинг (бейдж в правом верхнем углу картинки)
            ratingBadge.topAnchor.constraint(equalTo: cardImageView.topAnchor,constant: 8),
            ratingBadge.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor,constant: -8),
            ratingBadge.widthAnchor.constraint(equalToConstant: 52),
            ratingBadge.heightAnchor.constraint(equalToConstant: 25),
            
            // 🔷 Звезда внутри бейджа (с padding: left 12, top/bottom 5)
            
            starIcon.leadingAnchor.constraint(equalTo: ratingBadge.leadingAnchor,constant: 12),
            starIcon.centerYAnchor.constraint(equalTo: ratingBadge.centerYAnchor),
            starIcon.widthAnchor.constraint(equalToConstant: 8),
            starIcon.heightAnchor.constraint(equalToConstant: 7),
            
            // 🔷 Текст рейтинга
            
            ratingLabel.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: 10),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingBadge.trailingAnchor, constant: -12),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingBadge.centerYAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: 16),
            ratingLabel.heightAnchor.constraint(equalToConstant: 15),
            
            
            //  Имя
            
            nameLabel.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo:leadingAnchor),
           // nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
           // nameLabel.widthAnchor.constraint(equalToConstant: 28),
            nameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            
            //  БЕЙДЖ ЦЕНЫ
            
            priceBadge.topAnchor.constraint(equalTo: cardImageView.bottomAnchor,constant: 10),
            priceBadge.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor,constant: 8),
            priceBadge.widthAnchor.constraint(equalToConstant: 53),
            priceBadge.heightAnchor.constraint(equalToConstant: 25),
            
            
            //  $ знак
            
            dollarSign.leadingAnchor.constraint(equalTo: priceBadge.leadingAnchor, constant: 12),
            dollarSign.centerYAnchor.constraint(equalTo: priceBadge.centerYAnchor),
            dollarSign.widthAnchor.constraint(equalToConstant: 10),
            
            //  Цена
            priceLabel.leadingAnchor.constraint(equalTo: dollarSign.trailingAnchor, constant:0),
            priceLabel.trailingAnchor.constraint(equalTo: priceBadge.trailingAnchor, constant: -12),
            priceLabel.centerYAnchor.constraint(equalTo: priceBadge.centerYAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 10),
            
            //  Локация
            
            locationIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 2),
            locationIcon.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 2),
            locationIcon.widthAnchor.constraint(equalToConstant: 10),
            locationIcon.heightAnchor.constraint(equalToConstant: 10),
            
            
            
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 2),
            locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor,constant: 4),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
            locationLabel.heightAnchor.constraint(equalToConstant: 15)
            
        ])
    }
    
    func configure(name: String,location: String,rating: String,price:String,image: UIImage?) {
        
        nameLabel.text = name
        locationLabel.text = location
        ratingLabel.text = rating
        cardImageView.image = image
        priceLabel.text = price
        
        
    }
    
}
