//
//  QRDataEntity.swift
//  proj-2017-b
//
//  Created by 下村一将 on 2017/12/08.
//  Copyright © 2017年 kazu. All rights reserved.
//

import Foundation
import Unbox

class QRDataEntity: Unboxable {
	var type: QRType
	var id: String?
	var name: String?
	
	required init(unboxer: Unboxer) throws {
		let t:String = try unboxer.unbox(key: "type")
		type = QRType.init(rawValue: t)
		id = unboxer.unbox(key: "id")
		name = unboxer.unbox(key: "name")
	}
	
	init(_ t:String, _ i: String, _ n: String) {
		self.type = QRType.init(rawValue: t)
		self.id = i
		self.name = n
	}
}

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
