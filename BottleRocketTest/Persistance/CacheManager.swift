//
//  CachingManager.swift
//  BottleRocketTest
//
//  Created by Vlastimir Radojevic on 31/12/19.
//  Copyright © 2019 Vlastimir. All rights reserved.
//
//  CacheManager that stores objects to device storage

import UIKit

class CacheManager {
    
    private static let cache = NSCache<NSString, NSData>()
    
    private static var cacheDirectory: String {
        get {
            NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        }
    }
    
    private class func cacheDirectoryFileURLPath(for urlString: String) -> URL {
        let cachePathURL = "\(cacheDirectory)/\(urlString)"
        return URL.init(fileURLWithPath: cachePathURL)
    }
    
    class func cacheData(data: Data, from urlString: String) {
        let destinationURL = cacheDirectoryFileURLPath(for: urlString)
        cache.setObject(NSData.init(data: data), forKey: NSString.init(string: urlString))
        do {
            try data.write(to: destinationURL)
        } catch {}
    }
    
    class func cachedImageFrom(urlString: String) -> (image: UIImage, urlString:String)?  {
        guard let imgData = cachedDataFrom(urlString: urlString), let image = UIImage(data: imgData) else { return nil }
        return (image, urlString)
    }
    
    class func cachedDataFrom(urlString: String) -> Data? {
        if let data = cache.object(forKey: NSString.init(string: urlString)) {
            return Data.init(referencing: data)
        } else {
            do {
                return try Data.init(contentsOf: cacheDirectoryFileURLPath(for: urlString))
            } catch {
                
            }
        }
        return nil
    }
}
