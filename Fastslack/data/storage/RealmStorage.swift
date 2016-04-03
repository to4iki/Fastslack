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

    init(persistent: Persistent = .Disc) {
        self.realm = persistent.toRealm()
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

    func read<A: Object>(type: A.Type) -> Results<A> {
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

    func deleteAll<A: Object>(type: A.Type) throws {
        try realm.write {
            realm.delete(read(type))
        }
    }

    func purge() throws {
        try realm.write {
            realm.deleteAll()
        }
    }
}
