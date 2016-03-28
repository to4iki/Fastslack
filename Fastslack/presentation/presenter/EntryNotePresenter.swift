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

		let dto = NoteWriteDto(body: body.value)

		sendUseCase.send(dto.convertSlackMessage(attr))
			.retry(sendRetryMaxAttemptCount)
			.flatMap { _ -> Observable<Note> in
				self.entryUseCase.entry(dto.convertNote())
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
