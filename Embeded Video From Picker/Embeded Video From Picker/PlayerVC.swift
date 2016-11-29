//
//  PlayerVC.swift
//  Embeded Video From Picker
//
//  Created by Alex Reichle on 11/22/16.
//  Copyright © 2016 Alex Reichle. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class PlayerVC : AVPlayerViewController {
    
    
    
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "savedVideoURL"), object: nil, queue: OperationQueue.main, using: startVideo)
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "stopVideo"), object: nil, queue: OperationQueue.main, using: {_ in 
        self.player?.pause()
})
        
    }
    
    func startVideo (notification : Notification) {
        print("In startVideo method in PLayerVC Class")
        
        let userInfoDictionary = notification.userInfo
        let path = userInfoDictionary?["URL"] as? URL
        
        self.player = AVPlayer(url: path!)
        self.player?.play()
    }
}
