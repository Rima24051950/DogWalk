//
//  Model.swift
//  DogWalk
//
//  Created by MacBook on 21.04.2026.
//
import UIKit

import Foundation

struct ChatListItem: Identifiable {
    let id: String
    let name: String
    let avatarName: String?
    let lastMessage: String
   // let timeAgo: String
    let hasUnread: Bool
    let isOnline: Bool
    
    // Пример данных для тестов
    static let mockData: [ChatListItem] = [
        ChatListItem(
            id: "1",
            name: "Will Knowles",
            avatarName: "Will",
            lastMessage: "Hey! How’s your dog? ∙ 1min",
          //  timeAgo: "1min",
            hasUnread: true,
            isOnline: true
        ),
        ChatListItem(
            id: "2",
            name: "Ryan Bond",
            avatarName: "Ryan",
            lastMessage: "Let’s go out! ∙ 5h",
           // timeAgo: "5h",
            hasUnread: false,
            isOnline: false
        ),
        ChatListItem(
            id: "3",
            name: "Sirena Paul",
            avatarName: "Sirena",
            lastMessage: "Hey! Long time no see ∙ 1min",
            //timeAgo: "1min",
            hasUnread: true,
            isOnline: false
        ),
        ChatListItem(
            id: "4",
            name: "Matt Chapman",
            avatarName: "Matt",
            lastMessage: "You fed the dog? ∙ 6h",
            //timeAgo: "6h",
            hasUnread: false,
            isOnline: false
        ),
        ChatListItem(
            id: "5",
            name: "Laura Pierce",
            avatarName: "Laura",
            lastMessage: "How are you doing? ∙ 7h",
            //timeAgo: "7h",
            hasUnread: false,
            isOnline: false
        ),
        ChatListItem(
            id: "6",
            name: "Hazel Reed",
            avatarName: "Hazel",
            lastMessage: "Hey! Long time no see ∙ 5h",
           // timeAgo: "5h",
            hasUnread: false,
            isOnline: true
        )
    ]
}
