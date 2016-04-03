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

	private let sendRetryMaxAttemptCount = 1

	private lazy var entryUseCase = EntryNoteUseCase()

	private lazy var sendUseCase = SendSlackUseCase()

	private lazy var configureSlackUseCase = ConfigureSlackUseCase()

	private(set) var body = Variable<String>("")

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

	func send() {
		guard let attr = messageAttribute else {
			fatalError("set attribute failure.")
		}

		let writer = NoteWriteDto(body: body.value)

		sendUseCase.send(writer.convertSlackMessage(attr))
			.retry(sendRetryMaxAttemptCount)
			.flatMap { _ -> Observable<Note> in
				self.entryUseCase.entry(writer.convertNote())
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
				self.sendUseCase.send(message)
			}
			.retry(sendRetryMaxAttemptCount)
			.flatMap { _ -> Observable<Note> in
				self.entryUseCase.entry(writer.convertNote())
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
