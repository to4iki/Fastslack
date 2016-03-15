//
//  CreateNoteUseCase.swift
//  Fastslack
//
//  Created by to4iki on 3/15/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

protocol CreateNoteUseCaseDelegate: class {
    
    func onSaveNoteSuccess()
    
    func onSaveNoteError()
}

final class CreateNoteUseCase: NSObject {
    
    weak var delegate: CreateNoteUseCaseDelegate?
    
    private lazy var realmNoteRepository = RealmNoteRepository()
}

extension CreateNoteUseCase {
    
    func create(text: String) -> Note {
        let note = Note()
        note.body = text
        
        return note
    }
    
    func save(note: Note) {
        do {
            try realmNoteRepository.entry(note)
            delegate?.onSaveNoteSuccess()
        } catch {
            delegate?.onSaveNoteError()
        }
    }
}
