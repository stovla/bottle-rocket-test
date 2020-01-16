//
//  UIImage+Extension.swift
//  BottleRocketTest
//
//  Created by Vlastimir Radojevic on 3/1/20.
//  Copyright © 2020 Vlastimir. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(fromURL urlString: String) {
        
        guard let imageURL = URL(string: urlString) else {
            return
        }
        DispatchQueue.global(qos: .userInteractive).async {
            
            guard let imageObj = CacheManager.cachedImageFrom(urlString: urlString)
                else {
                    let request = URLRequest(url: imageURL)
                    URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                        if let data = data,
                            let image = UIImage(data: data),
                            urlString == response?.url?.absoluteString {
                            CacheManager.cacheData(data: data, from: urlString)
                            self.assignImage(image)
                        }
                    }).resume()
                    return
            }
            if imageObj.urlString == urlString {
                self.assignImage(imageObj.image)
            }
        }
    }
    
    fileprivate func assignImage(_ image: UIImage) {
        
        DispatchQueue.main.async {
            if self.image == nil {
                self.image = image
            }
        }
    }
}
