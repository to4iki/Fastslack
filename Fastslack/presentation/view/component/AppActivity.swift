//
//  AppActivity.swift
//  Fastslack
//
//  Created by to4iki on 4/3/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import Accounts
import Result

final class AppActivity {

	private let item: ActivityItem

	private let applicationActivities = [SendNoteAgainActivity()]

	private lazy var activityViewController: UIActivityViewController =
		UIActivityViewController(activityItems: self.item.toArray(), applicationActivities: self.applicationActivities)

	init(item: ActivityItem) {
		self.item = item
	}
}

extension AppActivity {

	func show(completedWithItemsHandler: Result<String, NSError> -> Void) {
		activityViewController.completionWithItemsHandler = { (type: String?, completed: Bool, items: [AnyObject]?, error: NSError?) in
			if let error = error {
				completedWithItemsHandler(.Failure(error))
			} else if let type = type {
				completedWithItemsHandler(.Success(type))
			}
		}

		UIApplication.sharedApplication().topViewController()?
			.presentViewController(activityViewController, animated: true, completion: nil)
	}
}
