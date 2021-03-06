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

    func findAll(order: Order = .Desc) -> [Note] {
        return storage.read(Note)
            .sorted([order.toSortDescriptor()])
            .reduce([], combine: { $0 + [$1] })
    }

    func store(note: Note) throws {
        try storage.add(note)
    }

    func delete(note: Note) throws {
        try storage.delete(note)
    }

    func deleteAll() throws {
        try storage.deleteAll(Note)
    }
}

// MARK: - Support

extension RealmNoteRepository {

    static func autoIncrementId() -> Int {
        return (RealmStorage().read(Note).last?.id ?? 0) + 1
    }
}
