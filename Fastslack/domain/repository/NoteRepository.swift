//
//  NoteRepository.swift
//  Fastslack
//
//  Created by to4iki on 3/14/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RealmSwift

/// I/F
protocol NoteRepository {
    
	func findAll(order: Order) -> [Note]
    
    func store(note: Note) throws
    
    func delete(note: Note) throws
}
