//
//  PhotoListViewControllerTableViewController.swift
//  PhotoSlideshow
//
//  Created by Masanori.KANEKO on 2015/08/23.
//  Copyright (c) 2015年 Masanori.KANEKO. All rights reserved.
//

import UIKit
import CoreData

class PhotoListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet var topToolBar: UIToolbar!
    @IBOutlet var buttonAddPhoto: UIBarButtonItem!
    var buttonEndEdit: UIBarButtonItem!

    @IBOutlet var photoListTableView: UITableView!
    var managedObjectContext: NSManagedObjectContext!
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "Photo")
        let primarySortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        fetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        frc.delegate = self
        
        return frc
    }()
    
    override func loadView() {
        super.loadView()
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        buttonEndEdit = UIBarButtonItem(title: "編集終了", style: UIBarButtonItemStyle.Plain, target: self, action: "tapButtonEndEdit:")
        self.fetchPhotoList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section] as! NSFetchedResultsSectionInfo
            return currentSection.numberOfObjects
        }
        return 0
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("photoListTableViewCell", forIndexPath: indexPath) as! UITableViewCell
        let photo = fetchedResultsController.objectAtIndexPath(indexPath) as! Photo
        
        cell.imageView?.image = UIImage(data: photo.image)
        cell.textLabel?.text = photo.title as String

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let photo = fetchedResultsController.objectAtIndexPath(indexPath) as! Photo
            managedObjectContext.deleteObject(photo)

            var error: NSError? = nil
            if managedObjectContext.hasChanges && !managedObjectContext.save(&error) {
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Actions
    
    func tapButtonEndEdit(sender: AnyObject?) -> Void {
        var items = [AnyObject]()
        items += topToolBar.items!
        items.removeLast()
        items += [buttonAddPhoto]
        topToolBar.items = items
        photoListTableView.setEditing(false, animated: true)
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        if type == .Delete {
            photoListTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    var imageDirectoryPath: String {
        let doc = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        return doc
    }
    
    private func fetchPhotoList() -> Void {
        var error: NSError? = nil
        if !fetchedResultsController.performFetch(&error) {
            abort()
        }
    }
    
    func loadPhotoList() -> Void {
        fetchPhotoList()
        photoListTableView.reloadData()
    }
    
    // MARK: IBAction
    
    @IBAction func swipeLeft() -> Void {
        var items = [AnyObject]()
        items += topToolBar.items!
        items.removeLast()
        items += [buttonEndEdit]
        topToolBar.items = items
        photoListTableView.setEditing(true, animated: true)
    }
}
