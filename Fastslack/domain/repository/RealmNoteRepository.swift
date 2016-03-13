//
//  RealmNoteRepository.swift
//  Fastslack
//
//  Created by to4iki on 3/14/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmNoteRepository: NoteRepository {
    
    private let storage: RealmStorage
    
    init(storage: RealmStorage = RealmStorage()) {
        self.storage = storage
    }
}

extension RealmNoteRepository {
    
    func findAll() -> Results<Note> {
        return storage.read(Note)
    }
    
    func entry(note: Note) throws {
        try storage.add(note)
    }
    
    func delete(note: Note) throws {
        try storage.delete(note)
    }
}
