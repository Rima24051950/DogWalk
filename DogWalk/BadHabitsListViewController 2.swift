//
//  BadHabitsListViewController.swift
//  
//
//  Created by MacBook on 27.04.2026.
//

import UIKit

class BadHabitsListViewController: UIViewController {
    
    // MARK: - UI Elements: Header Labels
    
    
    private let headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
        
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "We'd love your pet"
        label.font = AppFont.interBold24()
        label.textColor = AppColor.textColor
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
       // label.widthAnchor.constraint(equalToConstant: 329).isActive = true
        label.heightAnchor.constraint(equalToConstant: 51).isActive = true
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tell us something about your dog"
        label.font = AppFont.interRegular18()
        label.textColor = AppColor.textSecondary
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
       
        //label.widthAnchor.constraint(equalToConstant: 316).isActive = true
        label.heightAnchor.constraint(equalToConstant: 26).isActive = true
        return label
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(headerStackView)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(subtitleLabel)
        
        setupConstraints()
     
    }
    
    
    
    private func setupConstraints () {
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerStackView.widthAnchor.constraint(equalToConstant: 329),
            
            
            titleLabel.widthAnchor.constraint(equalToConstant: 329),
            
            subtitleLabel.widthAnchor.constraint(equalToConstant: 316)
            
        ])
    }
}
