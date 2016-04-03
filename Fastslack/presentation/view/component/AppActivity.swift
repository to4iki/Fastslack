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

	private let text: String

	private let url: NSURL?

	private let image: UIImage?

	private var activityItems: [AnyObject] {
		return [text] + [url, image].reduce([]) { (acc: [AnyObject], x: AnyObject?) in
			if let x = x {
				return acc + [x]
			} else {
				return acc
			}
		}
	}

	private lazy var activityViewController: UIActivityViewController =
		UIActivityViewController(activityItems: self.activityItems, applicationActivities: nil)

	init(text: String, url: NSURL? = nil, image: UIImage? = nil) {
		self.text = text
		self.url = url
		self.image = image
	}
}

extension AppActivity {

	func show(completedWithItemsHandler: Result<String, NSError> -> Void) {
		activityViewController.completionWithItemsHandler = { (type: String?, completed: Bool, items: [AnyObject]?, error: NSError?) in
			if completed {
				if let error = error {
					completedWithItemsHandler(.Failure(error))
				} else if let type = type {
					completedWithItemsHandler(.Success(type))
				}
			}
		}

		UIApplication.sharedApplication().topViewController()?
			.presentViewController(activityViewController, animated: true, completion: nil)
	}
}
