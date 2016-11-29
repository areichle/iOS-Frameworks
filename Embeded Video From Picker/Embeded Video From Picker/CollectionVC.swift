//
//  CollectionVCCollectionViewController.swift
//  Embeded Video From Picker
//
//  Created by Alex Reichle on 11/22/16.
//  Copyright © 2016 Alex Reichle. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

protocol toGetVideo {
    func testSelectedVideo(Asset : AVAsset)
}

private let reuseIdentifier = "Cell"

class CollectionVC: UICollectionViewController {

    public var delegate : toGetVideo!
    
    var videoAssets : PHFetchResult<PHAsset>!
    var videoArray = [CGImage]()
    var timeArray = [CMTime]()
    let imgCacheManager = PHCachingImageManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Do any additional setup after loading the view.
        
        let stopVideo = Notification.init(name: Notification.Name(rawValue: "stopVideo"))
        NotificationCenter.default.post(stopVideo)
        
        getMedia()
        self.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getMedia () {
        let videosAlbum = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumVideos, options: nil)
        
        print(videosAlbum.count)
        self.videoAssets = PHAsset.fetchAssets(in: videosAlbum.object(at: 0), options: nil)
        print(self.videoAssets.count)
        
        self.imgCacheManager.startCachingImages(for: self.videoAssets.objects(at: [0, videoAssets.count-1]), targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFit, options: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.videoAssets.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionCell
    
        self.imgCacheManager.requestImage(for: self.videoAssets.object(at: indexPath.item), targetSize: CGSize(width: 180, height: 180), contentMode: .aspectFill, options: nil, resultHandler: {
            result, info in
            cell.thumbnailImage = result! as UIImage
        })
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let options = PHVideoRequestOptions()
        options.isNetworkAccessAllowed = true
        
        let selectedAsset = self.imgCacheManager.requestAVAsset(forVideo: self.videoAssets.object(at: indexPath.item), options: options, resultHandler: {
            asset, _,_ in
            print("in AVAsset handler")
            
            self.delegate.testSelectedVideo(Asset: asset!)
            
        })
    }
}
