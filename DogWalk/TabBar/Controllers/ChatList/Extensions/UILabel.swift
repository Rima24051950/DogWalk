//
//  UILabel.swift
//  DogWalk
//
//  Created by MacBook on 23.04.2026.
//
import UIKit

extension UILabel {
    
    static func makeLabel(
        text: String? = nil,
        font: UIFont,
        textColor: UIColor,
        alignment: NSTextAlignment = .left,
        numberOfLines: Int = 1
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func makeTitle(_ text: String) -> UILabel {
        makeLabel(
            text: text,
            font: AppFont.interBold24(),
            textColor: .label
        )
    }
    
    static func makeSubtitle(_ text: String) -> UILabel {
        makeLabel(
            text: text,
            font: UIFont.systemFont(ofSize: 16, weight: .regular),
            textColor: AppColor.textColor,
            numberOfLines: 2
        )
    }
    
    static func makeTime(_ text: String) -> UILabel {
        makeLabel(
            text: text,
            font: UIFont.systemFont(ofSize: 14, weight: .regular),
            textColor: AppColor.textColor
        )
    }
}
