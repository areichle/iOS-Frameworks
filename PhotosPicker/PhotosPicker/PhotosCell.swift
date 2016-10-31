//
//  PhotosCell.swift
//  PhotosPicker
//
//  Created by Alex Reichle on 10/28/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var photoThumbnail: UIImageView!
    
    var assetIdentifier : String!
    
    var thumbnailImage: UIImage! {
        didSet {
            photoThumbnail.image = thumbnailImage
        }
    }
}
