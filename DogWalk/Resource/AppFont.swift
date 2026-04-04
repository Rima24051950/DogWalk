//
//  AppFont.swift
//  DogWalk
//
//  Created by MacBook on 05.03.2026.
//
// AppFont.swift
import UIKit

enum AppFont {
    
    // MARK: - Размеры
    enum Size: CGFloat {
        case size_18 = 18
        case size_24 = 24
    }
    
    // MARK: - Веса
    enum Weight {
        case regular
        case medium
        case semibold
        case bold
    }
    
    // MARK: - Inter font family
    static func inter(size: Size, weight: Weight) -> UIFont {
        let fontName: String
        switch weight {
        case .regular:  fontName = "Inter-Regular"
        case .medium:   fontName = "Inter-Medium"
        case .semibold: fontName = "Inter-SemiBold"
        case .bold:     fontName = "Inter-Bold"
        }
        
        // Попытка загрузить Inter, иначе fallback на системный
        return UIFont(name: fontName, size: size.rawValue)
            ?? UIFont.systemFont(ofSize: size.rawValue, weight: weight.uiWeight)
    }
    
    // MARK: - Удобные методы (Quick Access)
    
    // Size 18
    static func interRegular18() -> UIFont { inter(size: .size_18, weight: .regular) }
    static func interMedium18() -> UIFont  { inter(size: .size_18, weight: .medium) }
    static func interSemibold18() -> UIFont{ inter(size: .size_18, weight: .semibold) }
    
    // Size 24
    static func interBold24() -> UIFont { inter(size: .size_24, weight: .bold) }
}

// MARK: - Helper extension
private extension AppFont.Weight {
    var uiWeight: UIFont.Weight {
        switch self {
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        }
    }
}
