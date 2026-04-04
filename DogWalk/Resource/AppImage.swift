//
//  AppImage.swift
//  DogWalk
//
//  Created by MacBook on 09.03.2026.
//


import UIKit

 enum AppImage {
    case onboardingBackground
    case paws
    case wooDog
    case facebook
    case googleLogo
     case step1
     case step2
     case step3
    
    var image: UIImage? {
        switch self {
        case .onboardingBackground: return UIImage(named: "onbordingImage")
        case .step1: return UIImage(named: "onbordingImage")
        case .step2: return UIImage(named: "onboardingStep2")
        case .step3: return UIImage(named: "onboardingStep3") 
        case .paws: return UIImage(named: "paws")
        case .wooDog: return UIImage(named: "woo dog")
        case .facebook: return UIImage(named: "facebook")
        case .googleLogo: return UIImage(named: "google-logo")
        }
    }
}
