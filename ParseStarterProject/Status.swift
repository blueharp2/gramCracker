//
//  Status.swift
//  gramCracker
//
//  Created by Lindsey on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class Status {

    var image: UIImage?
    var thumbnail: UIImage?
    var statusText: String
    var imagePFFile: PFFile?
    
    init(image:UIImage?, statusText:String, thumbnail:UIImage?, imagePFFile: PFFile?){
        self.image = image
        self.statusText = statusText
        self.thumbnail = thumbnail
        self.imagePFFile = imagePFFile
    }
    
}
