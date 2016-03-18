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
    
    private lazy var fetchUseCase = FetchNoteUseCase()
    
    private lazy var deleteUseCase = DeleteNoteUseCase()
    
    private(set) var variable = Variable<[Note]>([])
}

// MARK: - Presenter

extension NoteListPresenter: Presenter {
    
    func viewDidLoad() {
        fetchAllNote()
    }
}

// MARK: Action

extension NoteListPresenter {
    
    private func fetchAllNote() {
        fetchUseCase.fetchAll()
            .subscribeNext { [unowned self] (note: Note) in
                self.variable.value.append(note)
            }
            .addDisposableTo(disposeBag)
    }
    
    func deleteNoteBy(index: Int) {
        let note = variable.value[index]
        
        deleteUseCase.delete(note)
            .subscribeNext { [unowned self] (success: Bool) in
                if success {
                    self.variable.value.removeAtIndex(index)
                }
            }
            .addDisposableTo(disposeBag)
    }
}
