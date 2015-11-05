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
        self.displayActionController()
        
    }
    
    @IBAction func filterButtonPressed(sender: UIButton) {
        presentFilterAlert()
    }

    
    @IBAction func UploadImage(sender: UIButton) {
        
        sender.enabled = false
        if let image = self.imageView.image{
            API.uploadImage(image, completion: { (sucess) -> () in
                if sucess {
                    sender.enabled = true
                  self.presentUploadSucessAlert()
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        
        if !UIImagePickerController.isSourceTypeAvailable(.Camera){
            cameraAction.enabled = false
        }
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
            photoLibraryAction.enabled = false
        }
        
        self.presentViewController(actionController, animated: true, completion: nil)
        
    }
    
    func presentUploadSucessAlert(){
        let alertController = UIAlertController(title: "", message: "Image sucessfully uploaded", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func presentFilterAlert(){
        let alertController = UIAlertController(title: "Filters", message: "Pick a filter:", preferredStyle: .ActionSheet)
        
        let applyBlackandWhiteEffect = UIAlertAction(title: "Black & White", style: .Default) { (action) -> Void in
            
            FilterService.applyBlackandWhiteEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage{
                    self.imageView.image = filteredImage
                }
            })
            
        }
        let applyVintageEffect = UIAlertAction(title: "Vintage", style: .Default) { (action) -> Void in
            
            FilterService.applyVintageEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage{
                    self.imageView.image = filteredImage
                }
            })
            
        }
        let applyBlurandSparkleEffect = UIAlertAction(title: "Blur & Sparkle", style: .Default) { (action) -> Void in
            
            FilterService.applyBlurandSparkleEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage{
                    self.imageView.image = filteredImage
                }
            })
            
        }
        let applyChromeEffect = UIAlertAction(title: "Chrome", style: .Default) { (action) -> Void in
            
            FilterService.applyChromeEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage{
                    self.imageView.image = filteredImage
                }
            })
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
       
            alertController.addAction(applyBlackandWhiteEffect)
            alertController.addAction(applyVintageEffect)
            alertController.addAction(applyBlurandSparkleEffect)
            alertController.addAction(applyChromeEffect)
            alertController.addAction(cancelAction)
        
        
                self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: Image Picker
    func presentImagePickerFor(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let resizedImage = UIImage.resizeImage(image, size: CGSize(width: 600, height: 600))
        self.imageView.image = resizedImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    
    
    
    
    
    
    
    
    
    //override func viewDidLoad() {
//        super.viewDidLoad()
//        need line that converts image into data here
//        let testObject = PFObject(className: "Status")
//        testObject["image"] = imagedata
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            print("Object has been saved.")
//        }
   // }
    
    
    