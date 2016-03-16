//
//  EntryNoteUseCase.swift
//  Fastslack
//
//  Created by to4iki on 3/15/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

protocol EntryNoteUseCaseDelegate: class {
    
    func onSaveNoteSuccess()
    
    func onSaveNoteError()
}

final class EntryNoteUseCase: NSObject {
    
    weak var delegate: EntryNoteUseCaseDelegate?
    
    private lazy var repository = RealmNoteRepository()
}

// MARK: - Action

extension EntryNoteUseCase {
    
    func create(text: String) -> Note {
        let note = Note()
        note.id = repository.autoIncrementId()
        note.body = text
        
        return note
    }
    
    func save(note: Note) {
        do {
            try repository.entry(note)
            delegate?.onSaveNoteSuccess()
        } catch {
            delegate?.onSaveNoteError()
        }
    }
}
