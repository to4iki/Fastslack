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

    private let note: Note

    init(entity: Note) {
        self.note = entity
        self.body = entity.body
        self.createdAt = dateFormatter.stringFromDate(entity.createdAt)
    }
}

// MARK: - Converter

extension NoteReadDto {

    func convertNote() -> Note {
        return note
    }
}
