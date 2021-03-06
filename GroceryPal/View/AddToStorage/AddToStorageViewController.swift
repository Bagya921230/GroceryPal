//
//  AddToStorageViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/1/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit
import BarcodeScanner


protocol ScanViewControllerDelegate {
    func didScan(msg: String)
}

class AddToStorageViewController: UIViewController {
    
    //MARK:- Outlet
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var manualContainerView: UIView!
    let viewController = BarcodeScannerViewController()
    var delegate: ScanViewControllerDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController.codeDelegate = self
        scanButton.createRoundedButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueManual"{
            if let vc = segue.destination as? ManualViewController {
                delegate = vc
                let onSaveBarItem = UIBarButtonItem(title: "Done", style: .done, target: vc, action: #selector(vc.onDoneAction))
                self.navigationItem.rightBarButtonItem  = onSaveBarItem
            }
        }
    }
    
    @IBAction func onScanClick(_ sender: Any) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension AddToStorageViewController : BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
            delegate!.didScan(msg: code)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
              controller.reset()
              controller.dismiss(animated: true, completion: nil)
              self.navigationController?.popViewController(animated: true)
            }
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
           Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                controller.reset()
                controller.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                Common.showAlert(msg: "Error occured in scanning", viewController: self)
           }
    }
}
