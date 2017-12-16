//
//  TopViewController.swift
//  proj-2017-b
//
//  Created by 下村一将 on 2017/12/08.
//  Copyright © 2017年 kazu. All rights reserved.
//

import UIKit
import Rswift

class TopViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		QRDataRepositoryImpl().sendQRData(QRPlaceEntity.init("id", "place_name"),
										  parts: [
											QRPartsEntity.init("id", "parts1"),
											QRPartsEntity.init("id", "parts2")
			])
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	@IBAction func inputDataButtonTapped(_ sender: Any) {
		let vc = ScanContainerViewController()
		self.navigationController?.pushViewController(vc, animated: false)
	}
	
	@IBAction func showDataButtonTapped(_ sender: Any) {
		let vc = R.storyboard.showDataViewController.instantiateInitialViewController()!
		self.navigationController?.pushViewController(vc, animated: true)
	}
}
