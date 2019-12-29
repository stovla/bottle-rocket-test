//
//  ImageRequest.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 29/12/2019.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import UIKit

class ImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    
    func decode(_ data: Data) -> UIImage? {
        // needs to cache image data
        return UIImage(data: data)
    }
    
    func load(withCompletion completion: @escaping (UIImage?) -> Void) {
        
    }
}
