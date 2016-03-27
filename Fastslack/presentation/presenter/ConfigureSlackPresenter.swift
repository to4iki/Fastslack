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
    
    var messageAttribute: Variable<MessageAttribute>?
}

// MARK: - Presenter

extension ConfigureSlackPresenter: Presenter {
    
    func viewWillAppear(animated: Bool) {
        fetchConfig()
    }
    
    func viewWillDisappear(animated: Bool) {
        storeWebHookURL()
    }
    
    func viewDidDisappear(animated: Bool) {
        refreshConfig()
    }
}

// MARK: - Action

extension ConfigureSlackPresenter {
    
    private func fetchConfig() {
        Observable.combineLatest(
            usecase.fetchWebHookURL(),
            usecase.fetchMessageAttribute()) {
                (url: $0, message: $1)
            }
            .subscribeNext { [unowned self] in
                self.webHookURL.value = $0.url.absoluteString
                self.messageAttribute?.value = $0.message
            }
            .addDisposableTo(disposeBag)
    }
    
    private func storeWebHookURL() {
        usecase.setWebHookURL(webHookURL.value)
            .subscribeCompleted {
                log.info("store webHookURL completed.")
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
