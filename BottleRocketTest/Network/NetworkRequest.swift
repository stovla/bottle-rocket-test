//
//  NetworkRequest.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 29/12/2019.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import UIKit

protocol NetworkRequest: AnyObject {

    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func load(withCompletion completion: @escaping (ModelType?) -> Void)
    func load(with url: URL, completionHandler: @escaping (Data?) -> Void)
}

extension NetworkRequest {
    
    // func load
    
//    func load(with url: URL, completionHandler: @escaping (Data?) -> Void) {
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
//        session.dataTask(with: url) { data, response, error in
//            guard let data = data else {
//                completionHandler(nil)
//                return
//            }
//            completionHandler(data)
//        }.resume()
//    }
}
