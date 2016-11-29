//
//  ViewController.swift
//  Embeded Video From Picker
//
//  Created by Alex Reichle on 11/22/16.
//  Copyright © 2016 Alex Reichle. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, toGetVideo{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testSelectedVideo(Asset: AVAsset) {
        self.dismiss(animated: true, completion: nil)
        // Save passed Asset to the temporary file directory
        let fileName = "TestVideo2.mov"
        let exportSession = AVAssetExportSession(asset: Asset, presetName: AVAssetExportPresetPassthrough)
        let url = URL(fileURLWithPath: NSTemporaryDirectory().appending(fileName))
        exportSession?.outputURL = url
        print(url.path)
        // MUST use path below here instead of .absoluteString!! Previous omits file://
        if FileManager.default.fileExists(atPath: url.path) {
            print("Removing previous item in Temp Diretory : " + url.path)
            try! FileManager.default.removeItem(at: url)
        }
        exportSession?.outputFileType = AVFileTypeQuickTimeMovie
        
        exportSession?.exportAsynchronously(completionHandler: {
            guard let status = exportSession?.status else {
                print("exportSession?.status not working properly on line 40-ish")
                return
            }
            switch (status) {
            case AVAssetExportSessionStatus.completed :
                print("Finished Successfully")
                let videoURLnotification = Notification(name: Notification.Name(rawValue: "savedVideoURL"), object: nil, userInfo: ["URL" : url])
                NotificationCenter.default.post(videoURLnotification)
            case AVAssetExportSessionStatus.exporting :
                print("working...")
                
            case AVAssetExportSessionStatus.failed :
                print("Failed... NEED FIXING")
            case AVAssetExportSessionStatus.waiting :
                print("Waiting...")
            case AVAssetExportSessionStatus.unknown :
                print("Unkown Status...")
            default:
                print("Default Hit")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toMediaViewer" {
            print("Destination is GetVideoVC")
            if let destinationVC = segue.destination as? CollectionVC {
                print("Delegate being set")
                destinationVC.delegate = self
            }
        }
        
    }
}

