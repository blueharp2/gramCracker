//
//  GalleryViewController.swift
//  gramCracker
//
//  Created by Lindsey on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit


protocol NewGalleryViewControllerDelegate{
    
    func newGalleryViewControllerImageSelected(image: UIImage)
}


class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
   
    
    var delegate: NewGalleryViewControllerDelegate?
    
    
    
    
    var collectionViewCellScale = CGFloat(1.0){
        didSet{
            self.galleryCollectionView.reloadData()
        }
    }
    
    var status = [Status](){
        didSet{
            self.galleryCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.dataSource = self
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinch:")
        view.addGestureRecognizer(pinchGesture)
        
            }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchStatus()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func pinch(sender: UIPinchGestureRecognizer){
        if let _ = sender.view{
           self.collectionViewCellScale = self.collectionViewCellScale / sender.scale
            sender.scale = 1.0
            //Add max/min limit here to control errors
        }
        
    }
    
    func fetchStatus(){
        API.getStatus { (results) -> () in
            if let statusResult = results{
               self.status = statusResult
            }
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.status.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCollectionViewCell", forIndexPath: indexPath) as! GalleryCollectionViewCell
        
        let status = self.status[indexPath.row]
        cell.status = status
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellEdgeSize = 200.0 * collectionViewCellScale
        return CGSizeMake(cellEdgeSize, cellEdgeSize)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let image = self.status[indexPath.row].imagePFFile
        image?.getDataInBackgroundWithBlock({ (data, error) -> Void in
            if let imageNSData = data{
                if let image = UIImage(data: imageNSData){
                    if let delegate = self.delegate {
                        delegate.newGalleryViewControllerImageSelected(image)
                        
                    }
                }
            }
            if let error = error{
                print("Error: \(error)")
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
