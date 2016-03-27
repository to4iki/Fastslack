//
//  EntryNotePresenter.swift
//  Fastslack
//
//  Created by to4iki on 3/15/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RxSwift

final class EntryNotePresenter {
    
    private let disposeBag = DisposeBag()
    
    private lazy var entryUseCase = EntryNoteUseCase()
    
    private lazy var sendUseCase = SendSlackUseCase()
}

// MARK: - Presenter

extension EntryNotePresenter: Presenter {
}

// MARK: - Action

extension EntryNotePresenter {
    
    func send(message: String) {
        let note = entryUseCase.create(message)
        
        sendUseCase.sendSlack(note.body)
            .retry(3)
            .flatMap { _ -> Observable<Note> in
                self.entryUseCase.entry(note)
            }
            .subscribeCompleted {
                log.info("send messsage completed.")
            }
            .addDisposableTo(disposeBag)
    }
}
