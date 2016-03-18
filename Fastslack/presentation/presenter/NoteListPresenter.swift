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
    
    private let usecase = FetchNoteUseCase()
    
    private(set) var variable = Variable<[Note]>([])
}

// MARK: - Presenter

extension NoteListPresenter: Presenter {
    
    func viewDidLoad() {
        usecase.fetchAll().subscribeNext { [unowned self] (note: Note) -> Void in
            self.variable.value.append(note)
        }.addDisposableTo(disposeBag)
    }
}
