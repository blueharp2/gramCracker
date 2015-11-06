//
//  FilterCollectionViewCell.swift
//  gramCracker
//
//  Created by Lindsey on 11/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var filterCellImage: UIImageView!
    
    var filteredImages : UIImage? {
        
        didSet{
            if let image = filteredImages{
                let size = CGSize(width: 100, height: 100)
                let thumbnail = UIImage.resizeImage(image, size: size)
                self.filterCellImage.image = thumbnail
            }
        }
    }
}