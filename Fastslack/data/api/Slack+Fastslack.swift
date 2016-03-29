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

	static var defaultChannel: String {
		return "#general"
	}

	static var defaultBotName: String {
		return "fastslack"
	}

	static var defaultIconEmoji: String {
		return ":slack:"
	}
}
