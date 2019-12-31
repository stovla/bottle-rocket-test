//
//  CachingManager.swift
//  BottleRocketTest
//
//  Created by Vlastimir Radojevic on 31/12/19.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import UIKit

class CacheManager {
    
    private static let cache = NSCache<NSString, NSData>()
    
    private static var cacheDirectory: String {
        get {
            NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        }
    }
    
    private class func cacheDestinationFileURL(for urlString: String) -> URL {
        let cachePathURL = "\(cacheDirectory)/\(urlString)"
        return URL.init(fileURLWithPath: cachePathURL)
    }
    
    class func cacheData(data: Data, from urlString: String) {
        let destinationURL = cacheDestinationFileURL(for: urlString)
        cache.setObject(NSData.init(data: data), forKey: NSString.init(string: urlString))
        do {
            try data.write(to: destinationURL)
        } catch {}
    }
    
    class func cachedDataFrom(urlString: String) -> Data? {
        if let data = cache.object(forKey: NSString.init(string: urlString)) {
            return Data.init(referencing: data)
        } else {
            do {
                return try Data.init(contentsOf: cacheDestinationFileURL(for: urlString))
            } catch {
                
            }
        }
        return nil
    }
    
    class func cachedImageFrom(urlString: String) -> UIImage? {
        if let imgData = cachedDataFrom(urlString: urlString) {
            return UIImage.init(data: imgData)
        }
        return nil
    }
    
    class func cachedDictionaryFrom(urlString: String) -> [AnyHashable : Any]? {
        return NSDictionary.init(contentsOfFile: cacheDestinationFileURL(for: urlString).path) as? [AnyHashable : Any] ?? nil
    }
}
