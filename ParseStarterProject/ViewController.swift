/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func imageViewButton(sender: UIButton) {
        print("Button Selected")
        
    }
    
//    var photoPicker = UIImagePickerController()
//    photoPicker.delegate = self
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func checkForCamera() -> Bool{
       if UIImagePickerController.isSourceTypeAvailable(.Camera){
            self.displayActionController()
       }else{
            return false
        }
    }
    
    func displayActionController(){
        let actionController = UIAlertController(title: "Action Controller", message: "Do you want to you use your camera or your photo library?", preferredStyle: .Alert)
        
        let cameraAction = UIAlertAction(title: "Camera", style:.Default) { (alert) -> Void in
            self.presentImagePickerFor(.Camera)
            }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .Default) { (alert) -> Void in
            self.presentImagePickerFor(.PhotoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionController.addAction(cameraAction)
        actionController.addAction(photoLibraryAction)
        actionController.addAction(cancelAction)
        
        self.presentViewController(actionController, animated: true, completion: nil)
        
    }
    
    func presentImagePickerFor(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
        
    }

    
    
    
    
    
    
    
    
    
    //override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let testObject = PFObject(className: "TestObject")
//        testObject["gram"] = "cracker"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            print("Object has been saved.")
//        }
   // }
    
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
}