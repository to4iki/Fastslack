//
//  UserDefaultsMessageAttributeRepository.swift
//  Fastslack
//
//  Created by to4iki on 3/19/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

// MARK: - MessageAttributeRepository

struct UserDefaultsMessageAttributeRepository: MessageAttributeRepository {
    
    func get() -> MessageAttribute? {
        let channel = Defaults[.channel]
        let botName = Defaults[.botName]
        let iconEmoji = Defaults[.iconEmoji]
        return MessageAttribute(channel: channel, botName: botName, iconEmoji: iconEmoji)
    }
    
    func store(attribute: MessageAttribute) {
        Defaults[.channel] = attribute.channel
        Defaults[.botName] = attribute.botName
        Defaults[.iconEmoji] = attribute.iconEmoji
    }
}
