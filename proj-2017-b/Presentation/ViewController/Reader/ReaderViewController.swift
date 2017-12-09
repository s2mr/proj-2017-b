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
import Unbox

class ReaderViewController: UIViewController {
	
	// Good practice: create the reader lazily to avoid cpu overload during the
	// initialization and each time we need to scan a QRCode
	lazy var readerVC: QRCodeReaderViewController = {
		let builder = QRCodeReaderViewControllerBuilder {
			$0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
			$0.showSwitchCameraButton = false
		}
		return QRCodeReaderViewController(builder: builder)
	}()
	
	var presenter: ReaderPresenter?
	func inject(_ p: ReaderPresenter) {
		self.presenter = p
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ReaderViewController: QRCodeReaderViewControllerDelegate {
	// MARK: - QRCodeReaderViewController Delegate Methods
	func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
		presenter?.didScan(res: result)
	}
	
	func readerDidCancel(_ reader: QRCodeReaderViewController) {
		reader.stopScanning()
		dismiss(animated: true, completion: nil)
	}
}

extension ReaderViewController {
	func setupUI() {
		// Retrieve the QRCode content
		// By using the delegate pattern
		readerVC.delegate = self
		
		// Presents the readerVC as modal form sheet
		readerVC.modalPresentationStyle = .formSheet
		present(readerVC, animated: true, completion: nil)
	}
}

