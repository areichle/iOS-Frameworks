//
//  ViewController.swift
//  PopoverPresentationController
//
//  Created by Alex Reichle on 12/3/16.
//  Copyright © 2016 Alex Reichle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, popoverProtocol {

    @IBAction func showPopover(_ sender: UIButton) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "Popover") as! PopoverVCViewController
        // VC.preferredContentSize = CGSize(width: 400, height: 500) <- Can also use this to present a view form your storyboard that has a custom sized view
        VC.delegate = self
        
        let navController = UINavigationController(rootViewController: VC)
        navController.modalPresentationStyle = .formSheet
        
        let popOver = navController.popoverPresentationController
        popOver?.delegate = self
        popOver?.sourceView = sender
        
        self.present(navController, animated: true, completion: nil)
    }

    func finishedEditing(textField: String) {
        print("Text Recieved: " + textField)
        self.dismiss(animated: true, completion: nil)
    }
}
