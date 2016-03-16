//
//  NoteListPresenter.swift
//  Fastslack
//
//  Created by to4iki on 3/16/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RxSwift

final class NoteListPresenter {
    
    private let disposeBag = DisposeBag()
    
    private let usecase = FetchNoteListUseCase()
}

// MARK: - Presenter

extension NoteListPresenter: Presenter {
    
    func viewDidLoad() {
        usecase.fetch().subscribeNext { (note: Note) -> Void in
            log.info(note.description)
        }.addDisposableTo(disposeBag)
    }
}
