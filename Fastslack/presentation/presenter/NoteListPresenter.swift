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

    private(set) var notes = Variable<[NoteReadDto]>([])
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
            .map { (note: Note) in
                NoteReadDto(entity: note)
            }
            .subscribeNext { [unowned self](note: NoteReadDto) in
                self.notes.value.append(note)
            }
            .addDisposableTo(disposeBag)
    }

    func refetch() {
        notes.value.removeAll()
        fetchNonExpiredNote()
    }

    func deleteNoteBy(index: Int) {
        let note = notes.value[index].convertNote()

        deleteUseCase.delete(note)
            .subscribeNext { [unowned self](success: Bool) in
                if success {
                    self.notes.value.removeAtIndex(index)
                }
            }
            .addDisposableTo(disposeBag)
    }
}
