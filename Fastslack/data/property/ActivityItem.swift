//
//  ActivityItem.swift
//  Fastslack
//
//  Created by to4iki on 4/3/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

struct ActivityItem {

	let text: String

	let url: NSURL?

	let image: UIImage?

	init(text: String, url: NSURL? = nil, image: UIImage? = nil) {
		self.text = text
		self.url = url
		self.image = image
	}
}

// MARK: - Encode/Decode

extension ActivityItem {

	func toArray() -> [AnyObject] {
		return [text] + [url, image].reduce([]) { (acc: [AnyObject], x: AnyObject?) in
			if let x = x {
				return acc + [x]
			} else {
				return acc
			}
		}
	}

	static func fromArray(items: [AnyObject]) -> ActivityItem {
		var text = ""
		var url: NSURL?
		var image: UIImage?

		items.forEach { (item: AnyObject) in
			switch item {
			case let i as String:
				text = i
			case let i as NSURL:
				url = i
			case let i as UIImage:
				image = i
			default:
				break
			}
		}

		return ActivityItem(text: text, url: url, image: image)
	}
}
