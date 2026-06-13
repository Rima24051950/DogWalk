//
//  GalleryPhotoCell.swift
//  DogWalk
//
//  Created by MacBook on 15.05.2026.
//

import UIKit


struct GalleryItem {
    let image: UIImage?
    let height: CGFloat
}

final class GalleryPhotoCell: UICollectionViewCell {
    static let identifier = "GalleryPhotoCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .systemGray4
        return iv
    }()
    
private var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        contentView.backgroundColor = .systemGray5
        contentView.addSubview(imageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with item: GalleryItem) {
      
        if item.image == nil {
    
        }
        
        imageView.image = item.image
        
        if let constraint = heightConstraint {
            constraint.constant = item.height
        } else {
            heightConstraint = imageView.heightAnchor.constraint(equalToConstant: item.height)
            heightConstraint?.isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
