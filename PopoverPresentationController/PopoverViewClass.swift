//
//  PopoverViewClass.swift
//  PopoverPresentationController
//
//  Created by Alex Reichle on 12/3/16.
//  Copyright © 2016 Alex Reichle. All rights reserved.
//
import AVKit
import Foundation

// This class must conform to all delegates for UI items
// We can use a protocol to pass final data to another/more important controller
class PopoverViewClass : UIViewController,UITextViewDelegate {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // UIPickerViewDataSource
    
}
