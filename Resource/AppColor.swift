//
//  AppColor.swift
//  DogWalk
//
//  Created by MacBook on 05.03.2026.
//

import UIKit



enum AppColor {
    
    // MARK: - Primary (основные)
    static let primary = UIColor(named: "primaryColor") ?? .systemOrange
    static let primaryGradient = UIColor(named: "primaryGradient") ?? .systemOrange
    static let secondary = UIColor(named: "secodary") ?? .systemGray
    
    // MARK: -  Background (фоны)
    static let background = UIColor(named: "background") ?? .white
    static let facebookround = UIColor(named: "secodary") ?? .white
    static let cardPlus = UIColor(named: "cardPlus") ?? .white
    static let surfase = UIColor(named: "surfase") ?? .white
    static let backgroundInput = UIColor(named: "background-input") 
    static let onSurfase = UIColor(named: "onSurfase") ?? .black
    
    // MARK: -  Text (текст)
    static let textColor = UIColor(named: "textColor") ?? .black
    static let textDark = UIColor(named: "textDark") ?? .black
    static let textSecondary = UIColor(named: "iconColor") ?? .systemGray
    static let otherText = UIColor(named: "otherText") ?? .systemGray
    
    // MARK: -  UI (иконки и элементы)
    static let iconColor = UIColor(named: "iconColor") ?? .black
    static let emogiiColor = UIColor(named: "emogiiColor") ?? .systemOrange
    static let disabled = UIColor(named: "disabled") ?? .systemGray
    static let color = UIColor(named: "Colorblack") ?? .black
}
