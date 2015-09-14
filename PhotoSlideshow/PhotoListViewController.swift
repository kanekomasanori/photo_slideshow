//
//  PhotoListViewController.swift
//  PhotoSlideshow
//
//  Created by Masanori.KANEKO on 2015/08/23.
//  Copyright (c) 2015年 Masanori.KANEKO. All rights reserved.
//

import UIKit
import CoreData

class PhotoListViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet var photoListTableVC: PhotoListTableViewController!
    @IBOutlet var buttonEdit: UIBarButtonItem!
    var managedObjectContext: NSManagedObjectContext!
    var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.persistentStoreCoordinator = appDelegate.persistentStoreCoordinator
        self.managedObjectContext = appDelegate.managedObjectContext

        photoListTableVC.managedObjectContext = managedObjectContext
        photoListTableVC.loadView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickImageFromLibrary() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if info[UIImagePickerControllerOriginalImage] != nil {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let data = UIImageJPEGRepresentation(image, 0.9)
            
            let addingContext: NSManagedObjectContext = NSManagedObjectContext()
            addingContext.persistentStoreCoordinator = self.persistentStoreCoordinator

            var photo: Photo = NSEntityDescription.insertNewObjectForEntityForName("Photo", inManagedObjectContext: addingContext) as! Photo
            
            photo.order = photoListTableVC.fetchedResultsController.fetchedObjects!.count + 1
            photo.image = data
            photo.memo = ""

            var error: NSError? = nil
            if addingContext.hasChanges && !addingContext.save(&error) {
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            } else {
                photoListTableVC.loadPhotoList()
            }
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var imageDirectoryPath: String {
        let doc = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        return doc
    }
    
    // MARK: - IBAction
    @IBAction func tapAddButton() -> Void {
        pickImageFromLibrary()
    }
    
    // MARK: IBAction
    @IBAction func tapButtonEdit(sender: AnyObject?) -> Void {
        if photoListTableVC.photoListTableView.editing {
            buttonEdit.title = "編集"
            photoListTableVC.photoListTableView.setEditing(false, animated: true)
        } else {
            buttonEdit.title = "完了"
            photoListTableVC.photoListTableView.setEditing(true, animated: true)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        NSLog("-prepareForSegue-----------------")
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        NSLog("-shouldPerformSegueWithIdentifier-----------------")
        return true;
    }

}
