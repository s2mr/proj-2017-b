//
//  QRDataSendRequest.swift
//  proj-2017-b
//
//  Created by 下村一将 on 2017/12/08.
//  Copyright © 2017年 kazu. All rights reserved.
//

import Foundation
import Alamofire

extension KagayaAPI {
	struct QRDataSendRequest {
		let place: QRPlaceEntity
		let parts: [QRPartsEntity]
	}
}

extension KagayaAPI.QRDataSendRequest: KagayaAPIRequest {
	typealias Response = String
	
	var method: HTTPMethod {
		return .post
	}
	
	var path: String {
		return "qr"
	}
	
	var parameters: Parameters? {
		return ["place": place,
				"parts": parts]
	}
}

