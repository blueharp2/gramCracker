//
//  FilterService.swift
//  gramCracker
//
//  Created by Lindsey on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class FilterService {
    private class func setupFilter(filterName: String, parameters: [String : AnyObject]?, imageToFilter: UIImage) -> UIImage?{
        
        let newCIImage = CIImage(image: imageToFilter)
        let filter : CIFilter
        
        if let parameters = parameters {
            filter = CIFilter(name: filterName, withInputParameters: parameters)!
        }else{
            filter = CIFilter(name: filterName)!
        }
        filter.setValue(newCIImage, forKey: kCIInputImageKey)
        
        
        
        let options = [kCIContextWorkingColorSpace : NSNull()]
        let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
        
        let outputImage = filter.outputImage
        let extent = outputImage?.extent
        let cgImage = gpuContext.createCGImage(outputImage!, fromRect: extent!)
        
        let finalImage = UIImage(CGImage: cgImage)
        
        return finalImage
        
    }
    class func applyBlackandWhiteEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        let filterName = "CIPhotoEffectMono"
        let displayName = "Black & White"
        
        let finalImage = setupFilter(filterName, parameters: nil, imageToFilter: image)
        
        completion(filteredImage: finalImage, name:displayName)
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
        
    }
    class func applyVintageEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        let filterName = "CIPhotoEffectTransfer"
        let displayName = "Vintage"
        
        let finalImage = setupFilter(filterName, parameters: nil, imageToFilter: image)
        
        completion(filteredImage: finalImage, name:displayName)
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
        
    }
    class func applyBlurandSparkleEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        let filterName = "CIBloom"
        let displayName = "Blur & Sparkle"
        
        let finalImage = setupFilter(filterName, parameters: ["inputRadius" : 10.00, "inputIntensity" : 1.00], imageToFilter: image)
        
        completion(filteredImage: finalImage, name:displayName)
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
        
    }
    class func applyChromeEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        let filterName = "CIPhotoEffectChrom"
        let displayName = "Chrome"
        
        let finalImage = setupFilter(filterName, parameters: nil, imageToFilter: image)
        
        completion(filteredImage: finalImage, name:displayName)
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
        
    }

}