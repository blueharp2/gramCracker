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


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, NewGalleryViewControllerDelegate, UITabBarControllerDelegate {
    
    var filteredImages = [UIImage](){
        didSet{
            self.filterCollectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func imageViewButton(sender: UIButton) {
        print("Button Selected")
        self.displayActionController()
        
    }
    
    @IBAction func filterButtonPressed(sender: UIButton) {
        displayFilterOptions { (image) -> () in
            self.filteredImages = image
            self.filterCollectionView.hidden = false
        }
        
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
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.hidden = true
        self.tabBarController?.delegate = self
        
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
    
    
    func displayFilterOptions(completion:(image: [UIImage]) ->()){
        var imageArray = [UIImage]()
        if let image = self.imageView.image{
            //let thumbnail = UIImage.resizeImage(image, size: CGSize(width: 100, height: 100))
            
            
            FilterService.applyBlackandWhiteEffect(image, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage{
                    imageArray.append(filteredImage)
                }
                
            })
            FilterService.applyVintageEffect(image, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage{
                    imageArray.append(filteredImage)
                }
                
            })
            FilterService.applyBlurandSparkleEffect(image, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage{
                    imageArray.append(filteredImage)
                }
                
            })
            FilterService.applyChromeEffect(image, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage{
                    imageArray.append(filteredImage)
                }
                
            })
            completion(image: imageArray)
        }
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
    
    
    //MARK:
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredImages.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterCollectionViewCell", forIndexPath: indexPath) as! FilterCollectionViewCell
        cell.filteredImages = self.filteredImages[indexPath.row]
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = collectionView.frame.height
        return CGSize(width: size, height: size)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.imageView.image = filteredImages[indexPath.row]
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if let viewController = viewController as? GalleryViewController {
            viewController.delegate = self
        }
    }
    func newGalleryViewControllerImageSelected(image: UIImage) {
        self.imageView.image = image
    }
}
    



    

    
    