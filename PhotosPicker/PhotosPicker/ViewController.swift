//
//  ViewController.swift
//  PhotosPicker
//
//  Created by Alex on 10/28/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getVideoButton(_ sender: UIButton) {
        //Media Picker instantiation
        let board = UIStoryboard(name: "Media Viewer", bundle: nil)
        let picker = board.instantiateViewController(withIdentifier: "MediaPicker")
        
        //Presenting Media Picker
        self.present(picker, animated: true, completion: nil)
        
    }

}

