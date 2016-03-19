//
//  UserDefaultsMessageRepository.swift
//  Fastslack
//
//  Created by to4iki on 3/19/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

// MARK: - MessageRepository

struct UserDefaultsMessageRepository: MessageRepository {
    
    func getMessage() -> Message? {
        let channel = Defaults[.channel]
        let botName = Defaults[.botName]
        let iconEmoji = Defaults[.iconEmoji]
        return Message(channel: channel, botName: botName, iconEmoji: iconEmoji)
    }
    
    func storeMessage(message: Message) {
        Defaults[.channel] = message.channel
        Defaults[.botName] = message.botName
        Defaults[.iconEmoji] = message.iconEmoji
    }
}
