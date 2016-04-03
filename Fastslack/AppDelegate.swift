//
//  AppDelegate.swift
//  Fastslack
//
//  Created by to4iki on 2/28/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        AppNavigation.setup()
        AppNotification.subscribe()

        return true
    }
}
