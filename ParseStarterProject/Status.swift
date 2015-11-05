//
//  Status.swift
//  gramCracker
//
//  Created by Lindsey on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class Status {
    var image: UIImage
    var thumbnail: UIImage?
    var status: String
    
    init(image:UIImage, status:String, thumbnail:UIImage?){
        self.image = image
        self.status = status
        self.thumbnail = thumbnail
    }
    
}
