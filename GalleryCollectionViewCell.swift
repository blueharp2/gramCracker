//
//  GalleryCollectionViewCell.swift
//  gramCracker
//
//  Created by Lindsey on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
//
//    
//    
//    
//    
    var status: [Status]{
//        didSet {
//            if let status = self.status {
//                self.collectionImageVIew.image = status.image
//                
//                }
        init(status: UIImage){
            self.status = status
        }
        
        }
    
    class func identifier() ->String{
        return "GalleryCollectionViewCell"
    }
}
