//
//  HabitCell.swift
//  DogWalk
//
//  Created by MacBook on 30.04.2026.
//

import UIKit



final class HabitCell: UICollectionViewCell {
    
    static let identifier = "HabitCell"
    
    // MARK: - UI Elements
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.disabled
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.tintColor = .label
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.interMedium18()
        label.textColor = AppColor.textColor
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Properties
    
    var isSelectedState: Bool = false {
        didSet { updateSelection() }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // Container
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            // Icon - выравнивание по макету (отступ сверху)
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 43),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            
            // Title - под иконкой
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with item: HabitItem) {
        iconImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        isSelectedState = item.isSelected
    }
    
    // MARK: - Selection
    
    private func updateSelection() {
        if isSelectedState {
            containerView.layer.borderWidth = 2
            containerView.layer.borderColor = AppColor.onSurfase.cgColor  //
            containerView.backgroundColor = AppColor.backgraundBadHab?.withAlphaComponent(0.1)
        } else {
            containerView.layer.borderWidth = 0
            containerView.layer.borderColor = nil
            containerView.backgroundColor = UIColor.systemGray6
        }
    }
    
    override var isSelected: Bool {
        didSet {
            isSelectedState = isSelected
        }
    }
}
