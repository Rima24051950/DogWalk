//
//  HabitItem.swift
//  DogWalk
//
//  Created by MacBook on 30.04.2026.
//

import UIKit

struct HabitItem: Identifiable {
    let id: Int
  //  let title: String
    let imageName: String
    let isSelected: Bool = true
    
    
    static let allHabits:[HabitItem] = [
                 HabitItem(id: 1,  imageName: "Barking"),
                HabitItem(id: 2,  imageName: "Chewing"),
                HabitItem(id: 3, imageName: "Digging"),
                HabitItem(id: 4,  imageName: "Begging"),
                HabitItem(id: 5, imageName: "Jumping"),
                HabitItem(id: 6,  imageName: "Growling")
    ]
}

