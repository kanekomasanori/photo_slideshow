//
//  ViewController.swift
//  PhotoSlideshow
//
//  Created by Masanori.KANEKO on 2015/08/23.
//  Copyright (c) 2015年 Masanori.KANEKO. All rights reserved.
//

import UIKit
import Photos

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var authorizationStatus: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case PHAuthorizationStatus.NotDetermined:
            PHPhotoLibrary.requestAuthorization( { (status: PHAuthorizationStatus) -> Void in
                if status == PHAuthorizationStatus.Authorized {
//                    self.pickImageFromLibrary()
                }
            })
            break
        case PHAuthorizationStatus.Authorized:
//            self.pickImageFromLibrary()
            break
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPhotoListView() -> Void {
        self.performSegueWithIdentifier("mainViewToPhotoListViewModal", sender: self)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if (identifier == "mainViewToPhotoListViewModal") {
            NSLog("hogehogehogehoge")
        }
        NSLog("%@", identifier!)
        return true
    }
    
    // MARK: IBAction
    @IBAction func longPressView(sender : AnyObject) {
        showPhotoListView()
    }
}

