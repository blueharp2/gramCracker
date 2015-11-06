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
    
    var filteredThumbnail : UIImage? {
        
        didSet{
            if let thumbnail = filteredThumbnail{
                self.filterCellImage.image = thumbnail
            }
        }
    }
}