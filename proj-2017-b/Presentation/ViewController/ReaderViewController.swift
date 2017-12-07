//
//  ViewController.swift
//  proj-2017-b
//
//  Created by 下村一将 on 2017/12/06.
//  Copyright © 2017年 kazu. All rights reserved.
//

import UIKit
import QRCodeReader
import AVFoundation

class ReaderViewController: UIViewController, QRCodeReaderViewControllerDelegate {
	
	// Good practice: create the reader lazily to avoid cpu overload during the
	// initialization and each time we need to scan a QRCode
	lazy var readerVC: QRCodeReaderViewController = {
		let builder = QRCodeReaderViewControllerBuilder {
			$0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
			$0.showSwitchCameraButton = false
		}
		
		return QRCodeReaderViewController(builder: builder)
	}()
	
	@objc func scanAction(_ sender: AnyObject) {

	}
	
	// MARK: - QRCodeReaderViewController Delegate Methods
	
	func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
		reader.stopScanning()
		
		dismiss(animated: true, completion: nil)
	}
	
	//This is an optional delegate method, that allows you to be notified when the user switches the cameraName
	//By pressing on the switch camera button
	func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
		let cameraName = newCaptureDevice.device.localizedName
		print("Switching capturing to: \(cameraName)")
		
	}
	
	func readerDidCancel(_ reader: QRCodeReaderViewController) {
		reader.stopScanning()
		
		dismiss(animated: true, completion: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
//		let button = UIButton(frame: CGRect(x: 0, y: 50, width: 100, height: 35))
//		button.titleLabel?.text = "スキャン"
//		button.setTitle(<#T##title: String?##String?#>, for: )
////		button.setTitle("スキャン", for: .normal)
//		button.addTarget(self, action: #selector(self.scanAction(_:)), for: .touchUpInside)
//
//		self.view.addSubview(button)
//
//		present(readerVC, animated: true, completion: nil)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		// Retrieve the QRCode content
		// By using the delegate pattern
		readerVC.delegate = self
		
		// Or by using the closure pattern
		readerVC.completionBlock = { (result: QRCodeReaderResult?) in
			print(result)
		}
		
		// Presents the readerVC as modal form sheet
		readerVC.modalPresentationStyle = .formSheet
		present(readerVC, animated: true, completion: nil)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

