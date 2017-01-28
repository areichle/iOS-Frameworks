//
//  ViewController.swift
//  Core Data & Multi-Threading
//
//  Created by Alex Reichle on 1/27/17.
//  Copyright © 2017 Alex Reichle. All rights reserved.
//

import UIKit

class MainScreen: UIViewController {
    
    var tableVC : TableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func backgroundToggle(_ sender: UISwitch) {
        // Updating through Notification Center because it's a demo project
    print("Recieved")
        let notification = Notification(name: Notification.Name(rawValue: "Toggle"), object: nil, userInfo: ["switch" : sender.isOn])
        NotificationCenter.default.post(notification)
    }

}

