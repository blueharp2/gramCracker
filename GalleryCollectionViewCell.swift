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

                if let imageData = status.imagePFFile{
                    imageData.getDataInBackgroundWithBlock({ (data, error) -> Void in
                        if let imageNSData = data{
                            let image = UIImage(data: imageNSData)
                                self.imageView.image = image
                        }
                        if let error = error{
                            print("Error: \(error)")
                        }
                    })
                }
            }
        }
    }
    
    class func identifier() ->String{
        return "GalleryCollectionViewCell"
    }
}
