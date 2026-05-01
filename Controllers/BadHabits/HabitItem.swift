//
//  HabitItem.swift
//  DogWalk
//
//  Created by MacBook on 30.04.2026.
//

import UIKit

struct HabitItem: Identifiable {
    let id: Int
    let title: String
    let imageName: String
    let isSelected: Bool = true
    
    
    static let allHabits:[HabitItem] = [
                 HabitItem(id: 1, title: "Barking", imageName: "Barking"),
                HabitItem(id: 2, title: "Chewing", imageName: "Chewing"),
                HabitItem(id: 3, title: "Digging", imageName: "Digging"),
                HabitItem(id: 4, title: "Begging", imageName: "Begging"),
                HabitItem(id: 5, title: "Jumping", imageName: "Jumping"),
                HabitItem(id: 6, title: "Growling", imageName: "Growling")
    ]
}

