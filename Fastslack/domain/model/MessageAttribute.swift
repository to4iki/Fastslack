//
//  MessageAttribute.swift
//  Fastslack
//
//  Created by to4iki on 3/19/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

struct MessageAttribute: ValueObject {
    
    let channel: String
    
    let botName: String
    
    let iconEmoji: String
}

// MARK: - CustomStringConvertible

extension MessageAttribute {
    
    var description: String {
        return "MessageAttribute(channel: \(channel), botName: \(botName), iconEmoji: \(iconEmoji))"
    }
}

// MARK: - Equtable

func == (lhs: MessageAttribute, rhs: MessageAttribute) -> Bool {
    return lhs.channel == rhs.channel && lhs.botName == rhs.botName && lhs.iconEmoji == rhs.iconEmoji
}
