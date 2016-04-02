//
//  NoteReadDto.swift
//  Fastslack
//
//  Created by to4iki on 4/2/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

struct NoteReadDto {

	let body: String

	let createdAt: String

	init(entity: Note) {
		self.body = entity.body
		self.createdAt = dateFormatter.stringFromDate(entity.createdAt)
	}
}
