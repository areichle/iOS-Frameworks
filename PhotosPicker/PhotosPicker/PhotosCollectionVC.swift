//
//  PhotosCollectionVC.swift
//  PhotosPicker
//
//  Created by Alex Reichle on 10/28/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "Cell"

class PhotosCollectionVC: UICollectionViewController {

    //MARK: Properties
    var videos : PHFetchResult<PHAsset>!
    var thumbnails : [UIImage]!
    
    let imageManager = PHCachingImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(PhotosCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        let videosAlbum = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumVideos, options: nil)

        print(videosAlbum.count)
        self.videos = PHAsset.fetchAssets(in: videosAlbum.object(at: 0), options: nil)
        print(self.videos.count)
        
        self.imageManager.startCachingImages(for: self.videos.objects(at: [0, videos.count-1]), targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFit, options: nil)
        
        for i in 0..<self.videos.count {
            self.imageManager.requestImage(for: videos.object(at: i), targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFit, options: nil, resultHandler: {
                image, _ in
                
                self.thumbnails?.append(image!)
            })
            
        }
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
        return 200 //videos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotosCell
        let asset = videos.object(at: indexPath.item)
        
        //cell.thumbnailImage = self.thumbnails?[indexPath.item]
        cell.assetIdentifier = asset.localIdentifier
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: {
            image, _ in
            
            if cell.assetIdentifier == asset.localIdentifier {
                    //print(cell?.thumbnailImage.description)
                    //print(image.debugDescription)
                    cell.thumbnailImage = image
            }
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

}
