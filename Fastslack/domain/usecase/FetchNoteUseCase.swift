//
//  FetchNoteUseCase.swift
//  Fastslack
//
//  Created by to4iki on 3/16/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RxSwift

final class FetchNoteUseCase {
    
    private lazy var repository = RealmNoteRepository()
}

extension FetchNoteUseCase {
    
    func fetchAll() -> Observable<Note> {
        return repository.findAll().toObservable()
    }
}
