//
//  Logger.swift
//  Fastslack
//
//  Created by to4iki on 3/1/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import XCGLogger

let log: XCGLogger = {
    let log = XCGLogger.defaultInstance()
    
    // color
    log.xcodeColorsEnabled = true // Or set the XcodeColors environment variable in your scheme to YES
    log.xcodeColors = [
        .Verbose: .lightGrey,
        .Debug: .darkGrey,
        .Info: .darkGreen,
        .Warning: .orange,
        .Error: .red,
        .Severe: .blue
    ]
    
    // date
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy hh:mma"
    dateFormatter.locale = NSLocale.currentLocale()
    log.dateFormatter = dateFormatter
    
    // setup
    log.setup(.Debug, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil)
    
    return log
}()
