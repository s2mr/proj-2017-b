//
//  KagayaAPI.swift
//  proj-2017-b
//
//  Created by 下村一将 on 2017/12/08.
//  Copyright © 2017年 kazu. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class KagayaAPI: API {
	let headers: HTTPHeaders = [:]
	
	func send<Req: KagayaAPIRequest>(request: Req) {
		let url = baseURL.appendingPathComponent(request.path)
		
		let req = Alamofire.request(url, method: request.method, parameters: request.parameters, encoding: encoding, headers: headers)
		print(req.debugDescription)
		req.responseJSON(completionHandler: { res in
			dump(res)
		})
	}
}

protocol KagayaAPIRequest {
	associatedtype Response
	var method: HTTPMethod { get }
	var path: String { get }
	var parameters: Parameters? { get }
}
