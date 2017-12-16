//
//  QRType.swift
//  proj-2017-b
//
//  Created by 下村一将 on 2017/12/16.
//  Copyright © 2017年 kazu. All rights reserved.
//

import Foundation

enum QRType: String {
	case Place = "place"
	case Parts = "parts"
	case None

	init(rawValue: String) {
		switch rawValue {
		case QRType.Place.rawValue:
			self = .Place
		case QRType.Parts.rawValue:
			self = .Parts
		default:
			self = .None
		}
	}
}

