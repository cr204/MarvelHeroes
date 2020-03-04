//
//  CustomImageView.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 3/1/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    static let memoryCache = NSCache<AnyObject, AnyObject>()
    static let cacheEvictionDays: TimeInterval = 1.0
    
    static let cacheUrl: URL = {
        var path: String = ""
        let groupName: String = "group." + (Bundle.main.bundleIdentifier ?? "com.cr204.MarvelHeroes")
        
        if let groupURL: URL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupName) {
            let cachePath: String = groupURL.appendingPathComponent("Caches").appendingPathComponent("Images").path
            path = cachePath
        } else {
            let imagePath = NSString(string: NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? "Caches").appendingPathComponent("Images")
            path = imagePath
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        
        var url: URL = URL(fileURLWithPath: path)
        
        var resourceValues = URLResourceValues()
        resourceValues.isExcludedFromBackup = true
        
        try? url.setResourceValues(resourceValues)
        
        return url
    }()
    
    private static var cleaningCache: Bool = false
    
    private static func performPossibleCacheCleanup() {
        DispatchQueue.main.async {
            guard !CustomImageView.cleaningCache else { return }
            CustomImageView.cleaningCache = true
            
            DispatchQueue.global().async {
                let keys: Set<URLResourceKey> = [.nameKey, .isDirectoryKey, .contentAccessDateKey]
                
                guard let enumerator = FileManager.default.enumerator(at: CustomImageView.cacheUrl, includingPropertiesForKeys: keys.map { $0 }) else { return }
                
                for case let url as URL in enumerator
                {
                    guard let resourceValues = try? url.resourceValues(forKeys: keys) else { continue }
                    let isDirectory = resourceValues.isDirectory ?? false
                    guard !isDirectory else { continue }
                    
                    let lastAccessedDate = resourceValues.contentAccessDate ?? Date()

                    guard lastAccessedDate.timeIntervalSinceNow < -(60.0 * 60.0 * 24.0 * CustomImageView.cacheEvictionDays) else { continue }

                    print("Cleaning file from cache url = \(url), file has not been accessed within \(CustomImageView.cacheEvictionDays) days")
                    
                    try? FileManager.default.removeItem(at: url)
                }
                
                DispatchQueue.main.async {
                    CustomImageView.cleaningCache = false
                }
            }
        }
    }
    
    var imageUrlString: String?
    
    func loadImageUsingURLString(urlString: String, fade: Bool = false, centerFit: Bool = false, cache: Bool = true) {
        
        imageUrlString = urlString
        
        let hash = urlString.utf8.reduce(5381) { ($0 << 5) &+ $0 &+ Int($1) }
        let hashFileName = "\(hash)" + ".jpg"
        
        let fileUrl = CustomImageView.cacheUrl.appendingPathComponent(hashFileName)
        guard let downloadURL = URL.init(string: urlString) else { return }
        
        if let imageForCache = CustomImageView.memoryCache.object(forKey: fileUrl as AnyObject) as? UIImage {
            self.image = imageForCache
            print("img - cache")
                        
        } else if let imageData = try? Data(contentsOf: fileUrl) {
            var imageToDisplay = UIImage(data: imageData)
            
            if let image = imageToDisplay, centerFit, let resizedImage = self.resizeImage(image: image, newWidth: 200) {
                imageToDisplay = resizedImage
            }
            
            self.image = imageToDisplay
                        
            if let image = imageToDisplay {
                CustomImageView.memoryCache.setObject(image, forKey: fileUrl as AnyObject)
            }
            
            print("img - local")
            
            if cache {
                try? imageData.write(to: fileUrl)
            }
            
            CustomImageView.performPossibleCacheCleanup()

            if fade {
                self.alpha = 0
                UIView.animate(withDuration: 0.5, animations: {
                    self.alpha = 1.0
                    return
                })
            } else {
                return
            }
            
        } else {
        
            let session = URLSession.shared
            
            let task = session.dataTask(with: downloadURL, completionHandler: { (data, response, error) in
                guard let data = data, let image = UIImage.init(data: data) else { return }
                var imageToCache: UIImage? = image
                
                    DispatchQueue.main.async {
                        if centerFit {
                            imageToCache = self.resizeImage(image: image, newWidth: 200)
                        }
                        
                        if self.imageUrlString == urlString {
                            self.image = imageToCache
                        }
                        
                        CustomImageView.memoryCache.setObject(imageToCache!, forKey: fileUrl as AnyObject)
                        self.image = imageToCache
                        
                        print("img - network")
                        
                        if fade {
                            self.alpha = 0
                            UIView.animate(withDuration: 0.5, animations: {
                                self.alpha = 1.0
                            })
                        }
                        
                        if cache {
                            try? data.write(to: fileUrl)
                        }
                }
            })
            task.resume()
        }
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
