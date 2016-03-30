//
//  ConfigureSlackUseCase.swift
//  Fastslack
//
//  Created by to4iki on 3/19/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RxSwift
import Slack

final class ConfigureSlackUseCase {

	private let configRepository: SlackConfigRepository

	private let messageAttributeRepository: MessageAttributeRepository

	init(configRepository: SlackConfigRepository = KeyChainSlackConfigRepository(),
	     messageAttributeRepository: MessageAttributeRepository = UserDefaultsMessageAttributeRepository()) {
		self.configRepository = configRepository
		self.messageAttributeRepository = messageAttributeRepository
	}
}

// MARK: - Action

extension ConfigureSlackUseCase {

	// MARK: Configure

	func configure() {
		fetchWebHookURL()
			.subscribe(
				onNext: { (url: NSURL) in
					Slack.configure(url.absoluteString)
				},
				onError: { error in
					log.error("\(error)")
				},
				onCompleted: { _ in
					log.info("fetch WebHookURL completed.")
				},
				onDisposed: nil
			)
			.dispose()
	}

	// MARK: Fetch

	func fetchWebHookURL() -> Observable<NSURL> {
		return Observable.create { observer in
			do {
				if let rawUrl = try self.configRepository.get(), url = NSURL(string: rawUrl) {
					observer.onNext(url)
					observer.onCompleted()
				} else {
					observer.onError(ErrorBundle.FetchError(message: "fetch WebHookURL failure."))
				}
			} catch let error {
				observer.onError(error)
			}

			return NopDisposable.instance
		}
	}

	func fetchMessageAttribute() -> Observable<MessageAttribute> {
		return Observable.create { observer in
			if let message = self.messageAttributeRepository.get() {
				observer.onNext(message)
				observer.onCompleted()
			} else {
				observer.onError(ErrorBundle.FetchError(message: "fetch message config failure"))
			}

			return NopDisposable.instance
		}
	}

	// MARK: Set

	func setWebHookURL(url: String) -> Observable<String> {
		return Observable.create { observer in
			do {
				try self.configRepository.store(url)
				observer.onNext(url)
				observer.onCompleted()
			} catch let error {
				observer.onError(error)
			}

			return NopDisposable.instance
		}
	}

	func setMessageAttribute(attribute: MessageAttribute) -> Observable<MessageAttribute> {
		return Observable.create { observer in
			self.messageAttributeRepository.store(attribute)
			observer.onNext(attribute)
			observer.onCompleted()

			return NopDisposable.instance
		}
	}
}
