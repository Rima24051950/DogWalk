//
//  UITextField.swift
//  DogWalk
//
//  Created by MacBook on 23.04.2026.
//

import UIKit

extension UITextField {
    
    static func makeSearchField() -> UITextField {
        let textField = UITextField()
        textField.placeholder = "Search..."
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.systemGray6
        textField.layer.cornerRadius = 12
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = .systemGray
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = searchIcon
        textField.leftViewMode = .always
        
      
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.rightView = paddingView
        textField.rightViewMode = .always
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return textField
    }
}
