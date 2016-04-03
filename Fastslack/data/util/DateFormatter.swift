//
//  DateFormatter.swift
//  Fastslack
//
//  Created by to4iki on 3/17/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation

let dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()

    formatter.timeStyle = .LongStyle
    formatter.dateStyle = .ShortStyle
    formatter.dateFormat = "yyyy/MM/dd HH:mm"

    return formatter
}()
