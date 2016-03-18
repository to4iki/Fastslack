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
    
    private lazy var client = Slack.sharedInstance
}

// MARK: - Action

extension SendSlackUseCase {
    
    func sendSlack(message: String) -> Observable<String> {
        return Observable.create { observer in
            self.client.sendSimpleMessage(message) { (data, error) -> Void in
                if let data = data, str = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
                    log.info(str)
                    observer.onNext(message)
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
