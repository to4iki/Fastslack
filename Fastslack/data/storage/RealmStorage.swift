//
//  RealmStorage.swift
//  Fastslack
//
//  Created by to4iki on 3/4/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmStorage {
    
    private let realm: Realm
    
    init(persistentType: Persistent = .InMemory) {
        self.realm = persistentType.toRealm()
    }
}

// MARK: - Persistent

extension RealmStorage {
    
    enum Persistent {
        case Disc
        case InMemory
        
        private func toRealm() -> Realm {
            switch self {
            case .Disc:
                return try! Realm()
            case .InMemory:
                return try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))
            }
        }
    }
}

// MARK: - Reader/Writer

extension RealmStorage {
    
    func read(type: Object.Type) -> Results<Object> {
        return realm.objects(type)
    }
    
    func add(object: Object) throws {
        try realm.write {
            realm.add(object)
        }
    }
    
    func delete(object: Object) throws {
        try realm.write {
            realm.delete(object)
        }
    }
}
