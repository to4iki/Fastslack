//
//  UIApplication+Fastslack.swift
//  Fastslack
//
//  Created by to4iki on 4/3/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

extension UIApplication {

	func topViewController() -> UIViewController? {
		guard var topViewController = UIApplication.sharedApplication().keyWindow?.rootViewController else {
			return nil
		}
		
		while case .Some = topViewController.presentedViewController {
			topViewController = topViewController.presentedViewController!
		}
		return topViewController
	}
}
