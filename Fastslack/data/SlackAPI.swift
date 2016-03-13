//
//  SlackAPI.swift
//  Fastslack
//
//  Created by to4iki on 3/14/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import Slack
import RxSwift

struct SlackAPI {
    
    private let client = Slack.sharedInstance
    
    func send(message: String) -> Observable<String> {
        return Observable.create { observer in
            self.client.sendSimpleMessage(message) { (data, error) -> Void in
                if let data = data, str = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
                    observer.onNext(str)
                }
                
                if let error = error {
                    observer.onError(Error.SendError(message: error.localizedDescription))
                }
            }
            
            return NopDisposable.instance
        }
    }
}

// MARK: Error

extension SlackAPI {
    
    enum Error: ErrorType {
        case SendError(message: String)
    }
}
