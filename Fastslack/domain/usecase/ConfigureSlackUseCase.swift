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
    
    private let configRepository = KeyChainSlackConfigRepository()
    
    private let messageRepository = UserDefaultsMessageRepository()
}

// MARK: - Action

extension ConfigureSlackUseCase {
    
    // MARK: Configure
    
    func configure() {
        fetchWebHookURL()
            .subscribe(
                onNext: { (url: NSURL) in Slack.configure(url.absoluteString) },
                onError: { _ in log.error("fetch WebHookURL failure.") },
                onCompleted: { _ in log.info("fetch WebHookURL completed.") },
                onDisposed: nil
            )
            .dispose()
    }
    
    // MARK: Fetch
    
    func fetchWebHookURL() -> Observable<NSURL> {
        return Observable.create { observer in
            do {
                if let rawUrl = try self.configRepository.getWebHookURL(), url = NSURL(string: rawUrl) {
                    observer.onNext(url)
                }
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            
            return NopDisposable.instance
        }
    }
    
    func fetchMessage() -> Observable<Message> {
        return Observable.create { observer in
            if let message = self.messageRepository.getMessage() {
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
                try self.configRepository.setWebHookURL(url)
                observer.onNext(url)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            
            return NopDisposable.instance
        }
    }
    
    func setMessage(message: Message) -> Observable<Message> {
        return Observable.create { observer in
            self.messageRepository.storeMessage(message)
            observer.onNext(message)
            observer.onCompleted()
            
            return NopDisposable.instance
        }
    }
}
