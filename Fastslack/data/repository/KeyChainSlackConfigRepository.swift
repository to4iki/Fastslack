//
//  KeyChainSlackConfigRepository.swift
//  Fastslack
//
//  Created by to4iki on 3/19/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

struct KeyChainSlackConfigRepository {
    
    private let storage: KeyChainStorage
    
    init(storage: KeyChainStorage = KeyChainStorage()) {
        self.storage = storage
    }
}

// MARK: - SlackConfigRepository

extension KeyChainSlackConfigRepository: SlackConfigRepository {
    
    private enum Key: String {
        case UrlString
    }
    
    func getWebHookURL() throws -> String? {
        return try storage.keyChain.get(Key.UrlString.rawValue)
    }
    
    func setWebHookURL(url: String) throws {
        try storage.keyChain.set(url, key: Key.UrlString.rawValue)
    }
}
