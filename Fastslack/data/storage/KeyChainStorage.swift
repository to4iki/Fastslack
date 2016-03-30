//
//  KeyChainStorage.swift
//  Fastslack
//
//  Created by to4iki on 3/19/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import KeychainAccess

struct KeyChainStorage {
    
    let keyChain: Keychain
    
    init(persistent: Persistent = .Default) {
        self.keyChain = persistent.toKeyChain()
    }
}

// MARK: - Persistent

extension KeyChainStorage {
    
    enum Persistent {
        case Default
        case Test
        
        private func toKeyChain() -> Keychain {
            switch self {
            case .Default:
                return Keychain()
            case .Test:
                return Keychain(service: "test")
            }
        }
    }
}
