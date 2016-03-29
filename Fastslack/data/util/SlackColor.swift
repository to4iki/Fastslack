//
//  SlackColor.swift
//  Fastslack
//
//  Created by to4iki on 3/29/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

struct SlackColor {

	/// columnBG
	static var purple: UIColor {
		return hexColor(0x4D394B)
	}

	/// activeItem
	static var green: UIColor {
		return hexColor(0x4C9689)
	}

	/// mentionBadge
	static var red: UIColor {
		return hexColor(0xEB4D5C)
	}

	private static func hexColor(hex: Int, alpha: Float = 1.0) -> UIColor {
		let r = Float((hex >> 16) & 0xFF) / 255.0
		let g = Float((hex >> 8) & 0xFF) / 255.0
		let b = Float((hex) & 0xFF) / 255.0
		return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(alpha))
	}
}
