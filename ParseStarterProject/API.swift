//
//  API.swift
//  gramCracker
//
//  Created by Lindsey on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

typealias ParseCompletionHandler = (sucess: Bool) -> ()

class API {
    class func uploadImage(image: UIImage, completion: ParseCompletionHandler){
        
        if let imageData = UIImageJPEGRepresentation(image, 0.7){
            let imageFile = PFFile(name: "image", data: imageData)
            let status = PFObject(className: "Status")
            status["image"] = imageFile
            
            status.saveInBackgroundWithBlock({ (sucess, error) -> Void in
                if sucess{
                    completion(sucess: sucess)
                } else {
                    completion(sucess: false)
                }
            })
        }
    }
    
    class func getStatus() ->([UIImage]?){
        
        let query = PFQuery(className: "Status")
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            print(results.count)
            for object in results{
                if let UIImageJPEGRepresentation(imag, 0.7) = imageData
    }
}


    

