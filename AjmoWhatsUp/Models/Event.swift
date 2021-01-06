//
//  Event.swift
//  AjmoWhatsUp
//
//  Created by Josip Hranić on 04.01.2021..
//

import Foundation

struct EventList: Decodable {

    let success: Bool
    let data: [Event]
}

struct Event: Decodable {

    let id: Int
    let image_url: String
    let share_link: String
    let isHighlighted: Bool
    let created_at: Date
    let updated_at: Date
    let caption: String
    let is_promoted: Int
    let highlighted_text: String
    let highlighted_icon: String
    let highlighted_gradient_color_first: String
    let highlighted_gradient_color_second: String
    let title: String
    let description: String
}
