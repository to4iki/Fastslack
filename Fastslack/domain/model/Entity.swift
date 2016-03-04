//
//  Entity.swift
//  Fastslack
//
//  Created by to4iki on 3/4/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

protocol Entity: CustomStringConvertible, Equatable {
    
    var id: Int { get }
}
