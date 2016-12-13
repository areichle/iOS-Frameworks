//
//  PopoverVCViewController.swift
//  PopoverPresentationController
//
//  Created by Alex Reichle on 12/4/16.
//  Copyright © 2016 Alex Reichle. All rights reserved.
//

import UIKit

protocol popoverProtocol {
    func finishedEditing(textField: String)
}

class PopoverVCViewController: UIViewController {
    
    var editField: String?
    public var delegate: popoverProtocol?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func doneButton(_ sender: UIButton) {
            guard let text = self.textField.text else {
            print("no text found")
            return
        }
        //do logic with text from textField -> return final text to delegate
        
        print(self.datePicker.date.debugDescription)
        //print(self.segControlPicker.titleForSegment)
        self.delegate?.finishedEditing(textField: text)
        
    }
  
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        let temp = sender.titleForSegment(at: sender.selectedSegmentIndex)
        print(temp)
    }
}
