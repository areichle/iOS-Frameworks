//
//  ViewController.swift
//  PopoverPresentationController
//
//  Created by Alex Reichle on 12/3/16.
//  Copyright © 2016 Alex Reichle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userDataPopover : UIPopoverPresentationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showPopover(_ sender: UIButton) {
        // trying to present the PopoverView.xib file as a popover
        // these all currently all have errors but I'm not sure why
        var toBePresented = PopoverViewClass()
        toBePresented.presentationStyle = .popover
        self.userDataPopover = UIPopoverPresentationController(presentedViewController: toBePresented, presenting: self)
        
        self.present(self.userDataPopover, animated: true, completion: nil)
    }
}

