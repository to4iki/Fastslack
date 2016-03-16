//
//  NoteRepository.swift
//  Fastslack
//
//  Created by to4iki on 3/14/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RealmSwift

protocol NoteRepository {
    
    func findAll() -> [Note]
    
    func entry(note: Note) throws
    
    func delete(note: Note) throws
}
