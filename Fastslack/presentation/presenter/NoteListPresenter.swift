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
    
    private(set) var notes = Variable<[Note]>([])
}

// MARK: - Presenter

extension NoteListPresenter: Presenter {
    
    func viewDidLoad() {
        fetchNonExpiredNote()
    }
}

// MARK: Action

extension NoteListPresenter {
    
    private func fetchNonExpiredNote() {
        fetchUseCase.fetchAll()
			.filter { (note: Note) in
				!note.expired
			}
            .subscribeNext { [unowned self] (note: Note) in
                self.notes.value.append(note)
            }
            .addDisposableTo(disposeBag)
    }
    
    func deleteNoteBy(index: Int) {
        let note = notes.value[index]
        
        deleteUseCase.delete(note)
            .subscribeNext { [unowned self] (success: Bool) in
                if success {
                    self.notes.value.removeAtIndex(index)
                }
            }
            .addDisposableTo(disposeBag)
    }
}
