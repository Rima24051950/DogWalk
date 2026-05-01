//
//  DateHeaderCell.swift
//  DogWalk
//
//  Created by MacBook on 09.04.2026.
//

import UIKit
class DateHeaderCell: UITableViewCell {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.disabled
        label.font = AppFont.interRegular18()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(dateLabel)
        backgroundColor = .clear
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with date: String) {
        dateLabel.text = date
    }
}
