//
//  ViewController.swift
//  PhotoSlideshow
//
//  Created by Masanori.KANEKO on 2015/08/23.
//  Copyright (c) 2015年 Masanori.KANEKO. All rights reserved.
//

import UIKit
import Photos
import CoreData

class MainViewController: UIViewController {
    @IBOutlet var photoDisplayCollectionVC: PhotoDisplayCollectionViewController!
    
    var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.persistentStoreCoordinator = appDelegate.persistentStoreCoordinator
        self.managedObjectContext = appDelegate.managedObjectContext
        
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
        photoDisplayCollectionVC.managedObjectContext = managedObjectContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBAction
    @IBAction func longPressView(sender : AnyObject) {
        self.performSegueWithIdentifier("mainViewToPhotoListViewModal", sender: sender)
    }
}

