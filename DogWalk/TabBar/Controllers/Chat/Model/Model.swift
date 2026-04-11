//
//  Model.swift
//  DogWalk
//
//  Created by MacBook on 09.04.2026.
//

import UIKit

enum ChatItem {
    case dateHeader (String)
    case message (Message)
}


struct Message {
    let text: String
    let isFromMe: Bool
    let date: Date

    init(text: String, isFromMe: Bool, date: Date) {
        self.text = text
        self.isFromMe = isFromMe
        self.date = date
    }
}
