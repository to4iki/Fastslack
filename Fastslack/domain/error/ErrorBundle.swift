//
//  ErrorBundle.swift
//  Fastslack
//
//  Created by to4iki on 3/18/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

enum ErrorBundle: ErrorType {
    
    case SendError(message: String)
    case FetchError(message: String)
    case StoreError(message: String)
    case DeleteError(message: String)
}
