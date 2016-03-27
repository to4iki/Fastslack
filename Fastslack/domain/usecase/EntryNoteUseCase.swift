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
    
    private let repository = RealmNoteRepository()
}

// MARK: - Action

extension EntryNoteUseCase {
    
    func entry(note: Note) -> Observable<Note> {
        return Observable.create { observer in
            do {
                try self.repository.store(note)
                observer.onNext(note)
                observer.onCompleted()
            } catch {
                observer.onError(ErrorBundle.StoreError(message: "entry note failure."))
            }
            
            return NopDisposable.instance
        }
    }
}
