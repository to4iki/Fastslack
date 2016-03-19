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
    
    private lazy var repository = KeyChainSlackConfigRepository()
}

// MARK: - Action

extension ConfigureSlackUseCase {
    
    func configure() {
        fetchWebHookURL()
            .subscribe(
                onNext: { (url: NSURL) in
                    Slack.configure(url.absoluteString)
                },
                onError: { _ in
                    log.error("fetch WebHookURL failure")
                },
                onCompleted: nil,
                onDisposed: nil
            )
            .dispose()
    }
    
    func setWebHookURL(url: String) -> Observable<String> {
        return Observable.create { observer in
            do {
                try self.repository.setWebHookURL(url)
                observer.onNext(url)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            
            return NopDisposable.instance
        }
    }
    
    private func fetchWebHookURL() -> Observable<NSURL> {
        return Observable.create { observer in
            do {
                if let rawUrl = try self.repository.getWebHookURL(), url = NSURL(string: rawUrl) {
                    observer.onNext(url)
                }
                
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            
            return NopDisposable.instance
        }
    }
}
