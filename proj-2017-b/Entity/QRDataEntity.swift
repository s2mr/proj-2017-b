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
	var type: String?
	var id: String?
	var name: String?
	
	required init(unboxer: Unboxer) throws {
		type = unboxer.unbox(key: "type")
		id = unboxer.unbox(key: "id")
		name = unboxer.unbox(key: "name")
	}
	
	init(_ t:String, _ i: String, _ n: String) {
		self.type = t
		self.id = i
		self.name = n
	}
}
