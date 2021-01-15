//
//  AddToStorageViewController.swift
//  GroceryPal
//
//  Created by Bhagya Gunawardena on 1/1/21.
//  Copyright © 2021 iit. All rights reserved.
//

import UIKit

protocol AddToStorageViewControllerDelegate {
    func onDoneAction()
}

class AddToStorageViewController: UIViewController {
    
    //MARK:- Outlet
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var scanContainer: UIView!
    @IBOutlet weak var manualContainerView: UIView!

    //MARK:- Action
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            scanContainer.alpha = 1
            manualContainerView.alpha = 0
        case 1:
            scanContainer.alpha = 0
            manualContainerView.alpha = 1
        default:
            break
        }
    }
    
    var delegate: AddToStorageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
//        style: .plain,
//        target: self,
//        action: #selector(onDoneAction))
//        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "#008891ff")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueManual"{
            if let vc = segue.destination as? ManualViewController {
                let addBarItem = UIBarButtonItem(title: "Done", style: .done, target: vc, action: #selector(vc.onDoneAction))
                self.navigationItem.rightBarButtonItem  = addBarItem
            }
        }
        if segue.identifier == "segueScan" && segmentedControl.selectedSegmentIndex == 0{
            if let vc = segue.destination as? ScanViewController {
                let addBarItem = UIBarButtonItem(title: "Done", style: .done, target: vc, action: #selector(vc.onDoneAction))
                self.navigationItem.rightBarButtonItem  = addBarItem
            }
        }
    }
    
    @objc
    func onDoneAction() {
        if self.delegate != nil {
            self.delegate?.onDoneAction()
        }
    }
    
    func configureUI() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.normal)
        scanContainer.alpha = 1
        manualContainerView.alpha = 0
    }

}
