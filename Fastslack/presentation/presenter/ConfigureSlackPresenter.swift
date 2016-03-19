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
    
    private lazy var usecase = ConfigureSlackUseCase()
    
    var webHookURL = Variable<String>("")
    
    var message: Variable<Message>?
}

// MARK: - Presenter

extension ConfigureSlackPresenter: Presenter {
    
    func viewWillAppear(animated: Bool) {
        fetchConfig()
    }
}

// MARK: - Action

extension ConfigureSlackPresenter {
    
    private func fetchConfig() {
        Observable.combineLatest(
            usecase.fetchWebHookURL(),
            usecase.fetchMessage()) {
                (url: $0, message: $1)
            }
            .subscribeNext { [unowned self] in
                self.webHookURL.value = $0.url.absoluteString
                self.message?.value = $0.message
            }
            .addDisposableTo(disposeBag)
    }
    
    func storeWebHookURL() {
        usecase.setWebHookURL(webHookURL.value)
            .subscribeCompleted {
                log.info("complete store webHookURL")
            }
            .addDisposableTo(disposeBag)
    }
    
    func refreshConfig() {
        if !webHookURL.value.isEmpty {
            Slack.configure(webHookURL.value)
        }
    }
}
