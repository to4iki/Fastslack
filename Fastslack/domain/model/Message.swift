//
//  Message.swift
//  Fastslack
//
//  Created by to4iki on 3/19/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

struct Message: ValueObject {
    
    let channel: String?
    
    let botName: String?
    
    let iconEmoji: String?
}

// MARK: - CustomStringConvertible

extension Message {
    
    var description: String {
        return "SlackMessage(channel: \(channel), botName: \(botName), iconEmoji: \(iconEmoji))"
    }
}

// MARK: - Equtable

func == (lhs: Message, rhs: Message) -> Bool {
    return lhs.channel == rhs.channel && lhs.botName == rhs.botName && lhs.iconEmoji == rhs.iconEmoji
}
