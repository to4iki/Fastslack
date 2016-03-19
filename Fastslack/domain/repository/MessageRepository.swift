//
//  MessageRepository.swift
//  Fastslack
//
//  Created by to4iki on 3/19/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

/// I/F
protocol MessageRepository {
    
    func getMessage() -> Message?
    
    func storeMessage(message: Message)
}
