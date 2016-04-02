//
//  AppNavigation.swift
//  Fastslack
//
//  Created by to4iki on 4/2/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

struct AppNavigation {

	static func setup() {
		UINavigationBar.appearance().barTintColor = SlackColor.purple
		UINavigationBar.appearance().tintColor = UIColor.whiteColor()
		UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
	}
}
