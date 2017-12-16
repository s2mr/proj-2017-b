//
//  API.swift
//  proj-2017-b
//
//  Created by 下村一将 on 2017/12/08.
//  Copyright © 2017年 kazu. All rights reserved.
//

import Foundation
import Alamofire

class API {
	let baseURL: URL = URL(string: Secret.apiURL)!
	let encoding: ParameterEncoding = JSONEncoding.default
}
