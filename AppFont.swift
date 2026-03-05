//
//  AppFont.swift
//  DogWalk
//
//  Created by MacBook on 05.03.2026.
//


// AppFont.swift
// AppFont.swift
import UIKit

enum AppFont {
    
    // MARK: - Размеры
    enum Size: CGFloat {
        case size_13 = 13
        case size_14 = 14
        case size_16 = 16
        case size_18 = 18
        case size_20 = 20
        case size_22 = 22
        case size_34 = 34 
    }
    
    // MARK: - Веса шрифтов
    enum Weight {
        case regular
        case medium
        case semibold
        case bold
    }
    
    // MARK: - Основной метод
    static func system(size: Size, weight: Weight) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: weight.uiWeight)
    }
    
    // MARK: - Удобные методы (quick access)
    static func semibold18() -> UIFont {
        return system(size: .size_18, weight: .semibold)
    }
    
    static func semibold16() -> UIFont {
        return system(size: .size_16, weight: .semibold)
    }
    
    static func regular18() -> UIFont {
        return system(size: .size_18, weight: .regular)
    }
    
    static func bold22() -> UIFont {
        return system(size: .size_22, weight: .bold)
    }
    
    static func bold13() -> UIFont {
        return system(size: .size_13, weight: .bold)
    }
    
    static func bold34() -> UIFont {
            return system(size: .size_34, weight: .bold)
        }
        
        static func semibold34() -> UIFont {
            return system(size: .size_34, weight: .semibold)
        }
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
