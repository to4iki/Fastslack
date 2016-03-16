//
//  RealmNoteRepository.swift
//  Fastslack
//
//  Created by to4iki on 3/14/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmNoteRepository {
    
    private let storage: RealmStorage
    
    init(storage: RealmStorage = RealmStorage()) {
        self.storage = storage
    }
}

// MARK: - NoteRepository

extension RealmNoteRepository: NoteRepository {
    
    func findAll() -> [Note] {
        return storage.read(Note).reduce([], combine: { $0 + [$1] })
    }
    
    func entry(note: Note) throws {
        try storage.add(note)
    }
    
    func delete(note: Note) throws {
        try storage.delete(note)
    }
}

extension RealmNoteRepository {
    
    func autoIncrementId() -> Int {
        return (storage.read(Note).last?.id ?? 0) + 1
    }
}
