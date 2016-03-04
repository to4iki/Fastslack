//
//  Note.swift
//  Fastslack
//
//  Created by to4iki on 3/4/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RealmSwift

final class Note: Object, Entity {
    
    dynamic var id: Int = 0
    
    dynamic var body: String = ""
    
    dynamic var createdAt: NSDate = NSDate()
}

// MARK: - Object

extension Note {
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Equtable

func == (lhs: Note, rhs: Note) -> Bool {
    return lhs.id == rhs.id && lhs.body == rhs.body && lhs.createdAt == rhs.createdAt
}
