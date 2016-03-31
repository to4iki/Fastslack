//
//  ConfigureSlackPresenter.swift
//  Fastslack
//
//  Created by to4iki on 3/20/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RxSwift
import Slack

final class ConfigureSlackPresenter {

	private let disposeBag = DisposeBag()

	private lazy var configureSlackUseCase = ConfigureSlackUseCase()

	private lazy var deleteNoteUseCase = DeleteNoteUseCase()

	private(set) var webHookURL = Variable<String>("")

	private(set) var channel = Variable<String>(Slack.Message.defaultChannel)

	private(set) var botName = Variable<String>(Slack.Message.defaultBotName)

	private(set) var iconEmoji = Variable<String>(Slack.Message.defaultIconEmoji)
}

// MARK: - Presenter

extension ConfigureSlackPresenter: Presenter {

	func viewWillAppear(animated: Bool) {
		fetchConfig()
	}

	func viewWillDisappear(animated: Bool) {
		storeWebHookURL()
		storeMessaegAttribute()
	}

	func viewDidDisappear(animated: Bool) {
		refreshConfig()
	}
}

// MARK: - Action

extension ConfigureSlackPresenter {

	private func fetchConfig() {
		Observable
			.zip(configureSlackUseCase.fetchWebHookURL(), configureSlackUseCase.fetchMessageAttribute()) {
				(url: $0, message: $1)
			}
			.subscribeNext { [unowned self] in
				self.webHookURL.value = $0.url.absoluteString
				self.channel.value = $0.message.channel
				self.botName.value = $0.message.botName
				self.iconEmoji.value = $0.message.iconEmoji
			}
			.addDisposableTo(disposeBag)
	}

	private func storeWebHookURL() {
		configureSlackUseCase.setWebHookURL(webHookURL.value)
			.subscribeCompleted {
				log.info("store webHookURL completed.")
			}
			.addDisposableTo(disposeBag)
	}

	private func storeMessaegAttribute() {
		let attr = MessageAttribute(channel: channel.value, botName: botName.value, iconEmoji: iconEmoji.value)

		configureSlackUseCase.setMessageAttribute(attr)
			.subscribeCompleted {
				log.info("store messageAttribute completed.")
			}
			.addDisposableTo(disposeBag)
	}

	private func refreshConfig() {
		if !webHookURL.value.isEmpty {
			log.info("configure webHookURL refreshed.")
			Slack.configure(webHookURL.value)
		}
	}
}
