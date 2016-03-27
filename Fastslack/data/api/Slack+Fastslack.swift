//
//  Slack+Fastslack.swift
//  Fastslack
//
//  Created by to4iki on 3/27/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import Slack

extension Slack.Message {
    
    var defaultChannel: String {
        return "@slackbot"
    }
    
    var defaultBotName: String {
        return "fastslack"
    }
    
    var defaultIconEmoji: String {
        return ":ghost:"
    }
}
