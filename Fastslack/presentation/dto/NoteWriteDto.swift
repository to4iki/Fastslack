//
//  NoteWriteDto.swift
//  Fastslack
//
//  Created by to4iki on 3/27/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import Slack

struct NoteWriteDto {

	private let body: String

	init(body: String) {
		self.body = body
	}
}

// MARK: - Converter

extension NoteWriteDto {

	func convertNote(id: Int = RealmNoteRepository.autoIncrementId()) -> Note {
		let note = Note()
		note.id = id
		note.body = body

		return note
	}

	func convertSlackMessage(attribute: MessageAttribute) -> Slack.Message {
		return Slack.Message.build { (m: Slack.Message) in
			m.channel(attribute.channel)
			m.botName(attribute.botName)
			m.iconEmoji(attribute.iconEmoji)
			m.text(self.body)
		}
	}
}
