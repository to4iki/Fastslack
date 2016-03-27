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
    
    private lazy var configureSlackUseCase = ConfigureSlackUseCase()
    
    private var messageAttribute: MessageAttribute?
}

// MARK: - Presenter

extension EntryNotePresenter: Presenter {
    
    func viewWillAppear(animated: Bool) {
        fetchAttribute()
    }
}

// MARK: - Action

extension EntryNotePresenter {
    
    func send(text: String) {
        guard let attr = messageAttribute else {
            fatalError("setup attribute failure.")
        }
        
        let dto = NoteWriteDto(body: text)
        
        sendUseCase.send(dto.convertSlackMessage(attr))
            .retry(3)
            .flatMap { _ -> Observable<Note> in
                self.entryUseCase.entry(dto.convertNote())
            }
            .subscribeCompleted {
                log.info("send messsage completed.")
            }
            .addDisposableTo(disposeBag)
    }
    
    private func fetchAttribute() {
        configureSlackUseCase.fetchMessageAttribute()
            .subscribeNext { [unowned self] in
                self.messageAttribute = $0
            }
            .addDisposableTo(disposeBag)
    }
}
