//
//  QRDataRepository.swift
//  proj-2017-b
//
//  Created by 下村一将 on 2017/12/08.
//  Copyright © 2017年 kazu. All rights reserved.
//

import Foundation

protocol QRDataRepository {
	func sendQRData(_ e: QRDataEntity)
}

class QRDataRepositoryImpl: QRDataRepository {
	let api = KagayaAPI()
	
	func sendQRData(_ e: QRDataEntity) {
		api.send(request: KagayaAPI.QRDataSendRequest(data: e))
	}
}
