//
//  TabBarM.swift
//  gallery
//
//  Created by kehwa weng on 2024/2/7.
//

import Foundation

struct TabBarM: Identifiable {
    var id = UUID()
    var iconName: String
    var tab: TabIcon
    var index: Int
}

enum TabIcon: String {
    case home
    case bell
    case message
    case like
    case person
}

let tabItems = [
    TabBarM(iconName: "house.fill", tab: .home, index: 0),
    TabBarM(iconName: "bell.fill", tab: .bell, index: 1),
    TabBarM(iconName: "message.fill", tab: .message, index: 2),
    TabBarM(iconName: "star.fill", tab: .like, index: 3),
    TabBarM(iconName: "person.fill", tab: .person, index: 4)
]
