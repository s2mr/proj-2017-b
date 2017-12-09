//
//  ScanContainerViewController.swift
//  proj-2017-b
//
//  Created by 下村一将 on 2017/12/10.
//  Copyright © 2017年 kazu. All rights reserved.
//

import UIKit

class ScanContainerViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		let vc = R.storyboard.readerViewController.instantiateInitialViewController()!
		vc.inject(ReaderPresenterImpl(vc))
		displayContentController(content: vc)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ScanContainerViewController {
	func displayContentController(content: UIViewController) {
		// 自身のビューコントローラ階層に追加
		// 自動的に子ViewControllerの`willMoveToParentViewController:`メソッドが呼ばれる
		self.addChildViewController(content)
		
		// 子ViewControllerの`view`を自身の`view`階層に追加
		self.view.addSubview(content.view)
		
		// 子ViewControllerに追加が終わったことを通知する
		content.didMove(toParentViewController: self)
	}
	
	func hideContentController(content: UIViewController) {
		// これから取り除かれようとしていることを通知する（引数が`nil`なことに注意）
		content.willMove(toParentViewController: nil)
		
		// 子ViewControllerの`view`を取り除く
		content.view.removeFromSuperview()
		
		// 子ViewControllerを取り除く
		// 自動的に`didMoveToParentViewController:`が呼ばれる
		content.removeFromParentViewController()
	}
}
