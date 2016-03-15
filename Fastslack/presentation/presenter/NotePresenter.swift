//
//  NotePresenter.swift
//  Fastslack
//
//  Created by to4iki on 3/15/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

final class NotePresenter {
    
    private let entryUseCase = EntryNoteUseCase()
    
    private let sendUseCase = SendNoteUseCase()
    
    func send(text: String) {
        let note = entryUseCase.create(text)
        sendUseCase.send(note)
    }
}

// MARK: - Presenter

extension NotePresenter: Presenter {
    
    func viewDidLoad() {
        entryUseCase.delegate = self
        sendUseCase.delegate = self
    }
}

// MARK: - EntryNoteUseCaseDelegate

extension NotePresenter: EntryNoteUseCaseDelegate {
    
    func onSaveNoteSuccess() {
        log.info("save note success.")
    }
    
    func onSaveNoteError() {
        log.error("save note error.")
    }
}

// MARK: - SendNoteUseCaseDelegate

extension NotePresenter: SendNoteUseCaseDelegate {
    
    func onSendNoteSuccess(message: String, note: Note) {
        log.info(message)
        entryUseCase.save(note)
    }
    
    func onSendNoteError(error: ErrorType) {
        log.error("send note error.")
    }
}
