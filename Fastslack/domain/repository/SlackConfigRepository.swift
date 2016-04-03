//
//  SlackConfigRepository.swift
//  Fastslack
//
//  Created by to4iki on 3/19/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

/// I/F
protocol SlackConfigRepository {

    func get() throws -> String?

    func store(url: String) throws
}
