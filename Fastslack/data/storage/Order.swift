//
//  Order.swift
//  Fastslack
//
//  Created by to4iki on 3/31/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RealmSwift

enum Order {
	case Asc
	case Desc
}

extension Order {

	func toSortDescriptor(property: String = "createdAt") -> SortDescriptor {
		switch self {
		case .Asc:
			return SortDescriptor(property: property, ascending: true)
		case .Desc:
			return SortDescriptor(property: property, ascending: false)
		}
	}
}
