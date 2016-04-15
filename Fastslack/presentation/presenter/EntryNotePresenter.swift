//
//  EntryNotePresenter.swift
//  Fastslack
//
//  Created by to4iki on 3/15/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RxSwift
import Slack

final class EntryNotePresenter {

    private let disposeBag = DisposeBag()

    private(set) var body = Variable<String>("")

    private let sendRetryMaxAttemptCount = 1

    private var messageAttribute: MessageAttribute?

    private let entryNoteUseCase: EntryNoteUseCase

    private let sendSlackUseCase: SendSlackUseCase

    private let configureSlackUseCase: ConfigureSlackUseCase

    init(
        entryNoteUseCase: EntryNoteUseCase = EntryNoteUseCase(),
        sendSlackUseCase: SendSlackUseCase = SendSlackUseCase(),
        configureSlackUseCase: ConfigureSlackUseCase = ConfigureSlackUseCase()
    ) {
        self.entryNoteUseCase = entryNoteUseCase
        self.sendSlackUseCase = sendSlackUseCase
        self.configureSlackUseCase = configureSlackUseCase
    }
}

// MARK: - Presenter

extension EntryNotePresenter: Presenter {

    func viewWillAppear(animated: Bool) {
        fetchAttribute()
    }
}

// MARK: - Action

extension EntryNotePresenter {

    func send() {
        guard let attr = messageAttribute else {
            fatalError("set attribute failure.")
        }

        let writer = NoteWriteDto(body: body.value)

        sendSlackUseCase.send(writer.convertSlackMessage(attr))
            .retry(sendRetryMaxAttemptCount)
            .flatMap { _ -> Observable<Note> in
                self.entryNoteUseCase.entry(writer.convertNote())
            }
            .subscribeCompleted { [unowned self] in
                self.body.value = ""
                log.info("send messsage completed.")
            }
            .addDisposableTo(disposeBag)
    }

    func forceSend(text: String) {
        let writer = NoteWriteDto(body: text)

        configureSlackUseCase.fetchMessageAttribute()
            .map { (attr: MessageAttribute) in
                writer.convertSlackMessage(attr)
            }
            .flatMap { [unowned self](message: Slack.Message) in
                self.sendSlackUseCase.send(message)
            }
            .retry(sendRetryMaxAttemptCount)
            .flatMap { _ -> Observable<Note> in
                self.entryNoteUseCase.entry(writer.convertNote())
            }
            .subscribeCompleted { [unowned self] in
                self.body.value = ""
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
