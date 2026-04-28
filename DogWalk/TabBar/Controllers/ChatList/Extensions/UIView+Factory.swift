//
//  UIView+Factory.swift
//  DogWalk
//
//  Created by MacBook on 21.04.2026.
//

import UIKit

extension UIView {
    
    static func makeView (
        backgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderWidth: CGFloat? = nil,
        borderColor: CGColor? = nil,
        clipsToBounds: Bool = true
    ) -> UIView {
        
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius ?? 0
        view.layer.borderWidth = borderWidth ?? 0
        view.clipsToBounds = clipsToBounds && (cornerRadius != nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }
    
    static func makeSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = AppColor.disabled
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1)
        ])
        return view
    }
}

