//
//  SendSlackUseCase.swift
//  Fastslack
//
//  Created by to4iki on 3/15/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RxSwift
import Slack

final class SendSlackUseCase {

    private let client = Slack.sharedInstance
}

// MARK: - Action

extension SendSlackUseCase {

    func send(message: Slack.Message) -> Observable<String> {
        return Observable.create { observer in
            self.client.sendMessage(message) { (data, error) -> Void in
                if let data = data, str = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
                    log.debug(str)
                    observer.onNext(str)
                    observer.onCompleted()
                }

                if let error = error {
                    observer.onError(ErrorBundle.SendError(message: error.localizedDescription))
                }
            }

            return NopDisposable.instance
        }
    }
}
