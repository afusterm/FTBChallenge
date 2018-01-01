//
//  ImageCache.swift
//  FTBChallenge
//
//  Created by Alejandro on 01/01/2018.
//  Copyright © 2018 Alejandro. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    public static let shared: ImageCache = ImageCache()
    
    let cache = NSCache<NSString, UIImage>()
    
    public func get(for urlString: String, cached: @escaping (_ image: UIImage) -> Void) {
        if let imageFromCache = cache.object(forKey: NSString(string: urlString)) {
            cached(imageFromCache)
            return
        }
        
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print(error!)
                    return
                }
                
                if let dataOK = data, let imageToCache = UIImage(data: dataOK) {
                    self.cache.setObject(imageToCache, forKey: NSString(string: urlString))
                    cached(imageToCache)
                }
            }
        }).resume()
    }
    
    public func empty() {
        cache.removeAllObjects()
    }
}
