//
//  GalleryCollectionViewCell.swift
//  gramCracker
//
//  Created by Lindsey on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit



class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    var status: Status? {
        didSet {
            if let status = self.status {
                self.imageView.image = status.image
                
            }
        }
    }
    
    class func identifier() ->String{
        return "GalleryCollectionViewCell"
    }
}
