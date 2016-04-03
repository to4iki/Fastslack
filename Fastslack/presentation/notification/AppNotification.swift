//
//  AppNotification.swift
//  Fastslack
//
//  Created by to4iki on 4/2/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class AppNotification {

    private let center = NSNotificationCenter.defaultCenter()

    private let disposeBag = DisposeBag()

    private let deleteNoteUseCase = DeleteNoteUseCase()

    private let configureSlackUseCase = ConfigureSlackUseCase()

    // MARK: Singleton

    private init() { }

    private static let shredInstance = AppNotification()

    // MARK: Setup

    static func subscribe() {
        let i = shredInstance
        i.bindDidFinishLaunching()
        i.bindDidBecomeActive()
        i.bindDidEnterBackground()
        i.bindWillTerminate()
        i.bindSignificantTimeChange()
    }
}

// MARK: - Bind

extension AppNotification {

    private func bindDidFinishLaunching() {
        center.rx_notification(UIApplicationDidFinishLaunchingNotification)
            .subscribeNext { [unowned self] _ in
                log.info("UIApplicationDidFinishLaunchingNotification")
                self.configureSlackUseCase.configure()
            }
            .addDisposableTo(disposeBag)
    }

    private func bindDidBecomeActive() {
        center.rx_notification(UIApplicationDidBecomeActiveNotification)
            .subscribeNext { _ in
                log.info("UIApplicationDidBecomeActiveNotification")
            }
            .addDisposableTo(disposeBag)
    }

    private func bindDidEnterBackground() {
        center.rx_notification(UIApplicationDidEnterBackgroundNotification)
            .subscribeNext { _ in
                log.info("UIApplicationDidEnterBackgroundNotification")
            }
            .addDisposableTo(disposeBag)
    }

    private func bindWillTerminate() {
        center.rx_notification(UIApplicationWillTerminateNotification)
            .subscribeNext { _ in
                log.info("UIApplicationWillTerminateNotification")
            }
            .addDisposableTo(disposeBag)
    }

    private func bindSignificantTimeChange() {
        center.rx_notification(UIApplicationWillTerminateNotification)
            .flatMap { [unowned self] _ in
                self.deleteNoteUseCase.deleteAllExpired()
            }
            .subscribeNext { _ in
                log.info("UIApplicationWillTerminateNotification")
            }
            .addDisposableTo(disposeBag)
    }
}
