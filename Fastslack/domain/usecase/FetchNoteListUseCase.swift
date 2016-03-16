//
//  FetchNoteListUseCase.swift
//  Fastslack
//
//  Created by to4iki on 3/16/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

final class FetchNoteListUseCase {
    
    private lazy var repository = RealmNoteRepository()
}

extension FetchNoteListUseCase {
    
    func fetch() -> Observable<Note> {
        return repository.findAll().toObservable()
    }
}
