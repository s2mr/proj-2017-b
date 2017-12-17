//
//  ReaderPresenter.swift
//  proj-2017-b
//
//  Created by 下村一将 on 2017/12/08.
//  Copyright © 2017年 kazu. All rights reserved.
//

import Foundation
import QRCodeReader
import Unbox

protocol ReaderPresenter {
	func didScan(res: QRCodeReaderResult)
}

class ReaderPresenterImpl: ReaderPresenter {
	let vc: ReaderViewController
	var willReadStatus = QRType.Place
	
	var place: QRPlaceEntity?
	{
		willSet {
			sendQRDataIfPrepared()
		}
	}
	var parts: [QRPartsEntity] = []
	
	init(_ vc: ReaderViewController) {
		self.vc = vc
	}
	
	func didScan(res: QRCodeReaderResult) {
		guard let _ = res.value.data(using: .utf8) else {
			return
		}
		
		let data = res.value.data(using: .utf8)!
		let unboxer = try! Unboxer(data: data)
		
		var qr: KagayaQREntity? = unboxer.unbox(key: "place") as QRPlaceEntity?
		
		if qr == nil {
			qr = unboxer.unbox(key: "parts") as QRPartsEntity?
		}
		
		dump(qr)
		
		guard let unQr = qr else {
			let ac = UIAlertController(title: "Error",
									   message: "QRコードが不正です",
									   preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			vc.dismiss(animated: true, completion: nil) // QRReaderを閉じる
			vc.present(ac, animated: true, completion: nil)
			return
		}
		
		switch unQr {
		case is QRPlaceEntity:
			print(".Place")
			place = unQr as? QRPlaceEntity
			if willReadStatus == .Place {
				willReadStatus = .Parts
				print("部品の読み取りに移行")
			} else if willReadStatus == .Parts {
				print("場所の読み取り\n部品の読み取りへ")
			}
		case is QRPartsEntity:
			parts.append(unQr as! QRPartsEntity)
			print(".Parts")
			if willReadStatus == .Parts {
				print("部品の読み取りを継続")
			} else if willReadStatus == .Place {
				print("場所を読み取ってください")
			}
		default:
			print(".None")
			print("不正なQRコードです")
		}
		
		let ac = UIAlertController(title: "\(type(of: unQr))",
								   message: "id: \(qr?.id ?? -1)\n\(qr?.name ?? "")",
			preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		vc.dismiss(animated: true, completion: nil) // QRReaderを閉じる
		vc.present(ac, animated: true, completion: nil)
		
		vc.readerVC.codeReader.stopScanning()
		vc.dismiss(animated: true, completion: nil)
	}
	
	func finishButtonTapped() {
		sendQRDataIfPrepared()
	}
	
	func sendQRDataIfPrepared() {
		if parts.count > 0 {
			if let place = place {
				QRDataRepositoryImpl().sendQRData(place, parts: parts)
			}
			parts = []
		}
	}
}
