//
//  CollectionCell.swift
//  Embeded Video From Picker
//
//  Created by Alex Reichle on 11/27/16.
//  Copyright © 2016 Alex Reichle. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    var thumbnailImage: UIImage! {
        didSet {
            imgView.image = thumbnailImage
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
    }
    
}
