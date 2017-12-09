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
	
	init(_ vc: ReaderViewController) {
		self.vc = vc
	}
	
	func didScan(res: QRCodeReaderResult) {
		if let data = res.value.data(using: .utf8) {
			var qr: QRDataEntity?
			do {
				let unboxer = try Unboxer(data: data)
				qr = unboxer.unbox(key: "qr")
			} catch (let e) {
				print(e)
			}
//			dump(a)
			let ac = UIAlertController(title: "QRCode",
									   message: "id: \(qr?.id ?? "")\n\(qr?.type ?? "")\n\(qr?.name ?? "")",
				preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			vc.present(ac, animated: true, completion: nil)
		}
//		vc.reader.stopScanning()
//		vc.readerVC.codeReader.stopScanning()
//		vc.dismiss(animated: true, completion: nil)
	}
}
