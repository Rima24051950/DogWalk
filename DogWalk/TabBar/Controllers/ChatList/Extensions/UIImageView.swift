//
//  UIImageView.swift
//  DogWalk
//
//  Created by MacBook on 23.04.2026.
//

import UIKit

extension UIImageView {
    
    static func makeAvatar(
        imageName: String?,
        size: CGFloat = 56,
        showOnlineDot: Bool = false
    ) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    container.widthAnchor.constraint(equalToConstant: size),
                    container.heightAnchor.constraint(equalToConstant: size)
                ])
    let imageView = UIImageView()
        imageView.image = imageName != nil  ?
        UIImage(named: imageName!):
        UIImage(named: "Will")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = size/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: container.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
                ])
                
                if showOnlineDot {
                    let onlineDot = UIView.makeView(backgroundColor: .systemOrange, cornerRadius: 6)
                    onlineDot.translatesAutoresizingMaskIntoConstraints = false
                    container.addSubview(onlineDot)
                    
                    NSLayoutConstraint.activate([
                        onlineDot.widthAnchor.constraint(equalToConstant: 12),
                        onlineDot.heightAnchor.constraint(equalToConstant: 12),
                        onlineDot.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                        onlineDot.bottomAnchor.constraint(equalTo: container.bottomAnchor)
                    ])
                }
                
                return container
        
    }
}
