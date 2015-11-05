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
    
    class func getStatus(completion: ([Status]?) -> ()){
        
        let query = PFQuery(className: "Status")
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
           
            var statusArray = [Status]()
            print(results?.count)
            
            if let results = results{
                for object in results {
                 
                   let imageFile = object["image"] as! PFFile
                    let statusText = ""

                    let status = Status(image: nil, statusText: statusText, thumbnail: nil, imagePFFile: imageFile)
                    statusArray.append(status)
                }
                completion(statusArray)
                
                
                }else{
                    if let error = error{
                        print("Error : \(error)")
                        
                    }
            }
        }
    }
}