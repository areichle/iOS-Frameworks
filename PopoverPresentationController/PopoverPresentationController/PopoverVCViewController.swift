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

class PopoverVCViewController: UIViewController, UITextFieldDelegate {
    
    var editField: String?
    public var delegate: popoverProtocol?
    var date : Date?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        textField.delegate = self
        self.navigationItem.title = "New Game"
        self.doneButton.layer.cornerRadius =  65
        
      /* Tried implementing 'Cancel' button where 'back' button would typically be
         self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(dismiss as (Void) -> Void))
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(dismiss as (Void) -> Void))
         */
        // DatePicker options in storyboard
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
            guard let text = self.textField.text else {
            print("no text found")
            print(date!)
            return
        }
        //do logic with text from textField -> return final text to delegate
        
        print(self.datePicker.date.description(with: Locale.current))
        //print(self.segControlPicker.titleForSegment)
        self.delegate?.finishedEditing(textField: text)
        
    }
  
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        let temp = sender.titleForSegment(at: sender.selectedSegmentIndex)
        print(temp)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        editField = textField.text
        print(editField)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    @IBAction func datePicker(_ sender: UIDatePicker) {
        print("New Date Selected")
    }
}
