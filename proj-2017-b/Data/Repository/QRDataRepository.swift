//
//  QRDataRepository.swift
//  proj-2017-b
//
//  Created by 下村一将 on 2017/12/08.
//  Copyright © 2017年 kazu. All rights reserved.
//

import Foundation

protocol QRDataRepository {
	func sendQRData(_ place: QRPlaceEntity, parts: [QRPartsEntity])
}

class QRDataRepositoryImpl: QRDataRepository {
	let api = KagayaAPI()
	
	func sendQRData(_ place: QRPlaceEntity, parts: [QRPartsEntity]) {
		api.send(request: KagayaAPI.QRDataSendRequest(place: place, parts: parts))
	}
}
