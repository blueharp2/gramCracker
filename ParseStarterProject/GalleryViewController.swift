//
//  GalleryViewController.swift
//  gramCracker
//
//  Created by Lindsey on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit



class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var status = [Status]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        API.getStatus()

    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.datasource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(<#T##identifier: String##String#>, forIndexPath: indexPath) as!
        GalleryViewControllerCell
        
        let status = self.datasource[indexPath.row]
        cell.status = status
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(200.00, 200.00)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
