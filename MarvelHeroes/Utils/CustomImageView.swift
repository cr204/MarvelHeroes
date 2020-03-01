//
//  CustomImageView.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 3/1/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    var imageUrlString: String?
    
    func loadImageUsingURLString(urlString: String, fade: Bool=false, centerFit: Bool=false, cornerRadius: CGFloat=0) {
        
        imageUrlString = urlString
        
        guard let url:URL = URL(string: urlString) else { return }
        
        self.image = nil
        
        //        if let imageForCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
        //            self.image = imageForCache
        //            return
        //        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            if data != nil {
                let image = UIImage(data: data!)
                if(image != nil) {
                    
                    DispatchQueue.main.async(execute: {
                        
                        var imageToCache = UIImage(data: data!)
                        
                        if centerFit {
                            //                            print("self: \(self.bounds.size.width)")
                            //                            print("image: \(imageToCache?.size.width)")
                            imageToCache = self.resizeImage(image: imageToCache!, newWidth: self.bounds.size.width)!
                        }
                        
                        //        if (imageView.bounds.size.width > ((UIImage*)imagesArray[i]).size.width && imageView.bounds.size.height > ((UIImage*)imagesArray[i]).size.height) {
                        
                        if self.imageUrlString == urlString {
                            self.image = imageToCache
                        }
                        
                        //                        imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                        //                        self.image = imageToCache
                        
                        if cornerRadius > 0 {
//                            self.roundCorners([.topLeft, .topRight], radius: cornerRadius)
                            self.roundCorners([.allCorners], radius: cornerRadius)
                        }
                        
                        if fade {
                            self.alpha = 0
                            UIView.animate(withDuration: 0.5, animations: {
                                self.alpha = 1.0
                            })
                        }
                    })
                }
            }
        })
        task.resume()
    }
    
    private func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}
