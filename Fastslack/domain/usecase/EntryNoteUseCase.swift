//
//  EntryNoteUseCase.swift
//  Fastslack
//
//  Created by to4iki on 3/15/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RxSwift

final class EntryNoteUseCase {
    
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
    
    func entry(note: Note) -> Observable<Note> {
        return Observable.create { observer in
            do {
                try self.repository.store(note)
                observer.onNext(note)
            } catch {
                observer.onError(ErrorBundle.StoreError(message: "entry note failure."))
            }
            
            observer.onCompleted()
            
            return NopDisposable.instance
        }
    }
}
