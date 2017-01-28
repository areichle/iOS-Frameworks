//
//  TableViewController.swift
//  Core Data & Multi-Threading
//
//  Created by Alex Reichle on 1/27/17.
//  Copyright © 2017 Alex Reichle. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var localArray = [(firstItem: String, secondItem: String)]()
    var onBackgroundThread = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TableViewController.addItem))
        
        self.loadCoreData()
        
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Toggle"), object: nil, queue: OperationQueue.main, using: {
            [weak self] (notification) in
            
            self?.onBackgroundThread =  notification.userInfo?["switch"] as! Bool
            NSLog("onBackgroundThread Bool set")
        })
    }

    func addItem() {
        let alertController = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Save", style: .default, handler: {
            (_) in
            var items = [String]()
            
            if let fieldOne = alertController.textFields![0] as? UITextField {
                items.append(fieldOne.text!)
            }
            
            if let fieldTwo = alertController.textFields![1] as? UITextField {
                items.append(fieldTwo.text!)
            }
            
            self.saveItems(firstItem: items[0], secondItem: items[1])
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField(configurationHandler: {
            (textField) in
            textField.placeholder = "First Item"
        })
        alertController.addTextField(configurationHandler: {
            (textField) in
            textField.placeholder = "Second Item"
        })
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    func saveItems(firstItem : String, secondItem : String) {
        
        if (self.onBackgroundThread == true) {
            
            CoreDataManager.sharedInstance.persistentContainer.performBackgroundTask({
                [weak self] (backgroundContext) in
                
                let firstEntity = FirstEntity(context: backgroundContext)
                firstEntity.text = firstItem
                
                let secondEntity = SecondEntity(context: backgroundContext)
                firstEntity.secondPartner = secondEntity
                secondEntity.text = secondItem
                
                self?.localArray.append((firstItem, secondItem))
                
                do {
                    // we still need to save before we end operations on this thread
                    // save from the background context - not by calling the singleton again
                    try backgroundContext.save()
                } catch {
                    NSLog("Could not save in background")
                }
                
                DispatchQueue.main.async {
                    // Need to call back to main thread to update UI
                    self?.tableView.reloadData()
                }
            })
            
            return
        }
        
        let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let firstEntity = FirstEntity(context: managedContext)
        
        firstEntity.text = firstItem
        
        let secondEntity = SecondEntity(context: managedContext)
        firstEntity.secondPartner = secondEntity
        secondEntity.text = secondItem
        
        CoreDataManager.sharedInstance.saveContext()
        
        localArray.append((firstItem, secondItem))
        
    }
    
    func loadCoreData() {
        let fetch = NSFetchRequest<FirstEntity>(entityName: "FirstEntity")
        
        do {
            let results = try CoreDataManager.sharedInstance.persistentContainer.viewContext.fetch(fetch)
            
            for each in results {
                self.localArray.append((each.text!, (each.secondPartner?.text)!))
            }
            
        } catch {
            NSLog("Problem fetching Core Data Store")
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.localArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        
        cell.textLabel?.text = self.localArray[indexPath.item].firstItem
        cell.detailTextLabel?.text = self.localArray[indexPath.item].secondItem
        
        
        return cell
    }
    
    // MARK: - Table view actions
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            if self.onBackgroundThread == false {
                let fetch = NSFetchRequest<FirstEntity>(entityName: "FirstEntity")
                
                do {
                    let results = try CoreDataManager.sharedInstance.persistentContainer.viewContext.fetch(fetch)
                    
                    for each in results {
                        if each.text == self.localArray[indexPath.item].firstItem {
                            CoreDataManager.sharedInstance.persistentContainer.viewContext.delete(each.secondPartner!)
                            CoreDataManager.sharedInstance.persistentContainer.viewContext.delete(each)
                            NSLog("Removed from Core Data")
                        }
                    }
                } catch {
                    NSLog("Could not delete object")
                }
                
                self.localArray.remove(at: indexPath.item)
                self.tableView.reloadData()
                return
            } else {
                //On background thread
                
                CoreDataManager.sharedInstance.persistentContainer.performBackgroundTask({
                    [weak self] (backgroundContext) in
                    
                    let fetch = NSFetchRequest<FirstEntity>(entityName: "FirstEntity")
                    
                    do {
                        let results = try backgroundContext.fetch(fetch)
                        
                        for each in results {
                            if each.text == self?.localArray[indexPath.item].firstItem {
                                backgroundContext.delete(each.secondPartner!)
                                backgroundContext.delete(each)
                                NSLog("Removed on background thread")
                            }
                        }
                    } catch {
                        NSLog("Could not delete on background thread")
                    }
                    
                    self?.localArray.remove(at: indexPath.item)
                    do {
                        try backgroundContext.save()
                    } catch {
                        NSLog("Cannot save on background thread")
                    }
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                })
            }
            
        }
    }

}
