//
//  NetworkManager.swift
//  BottleRocketTest
//
//  Created by Vlastimir Radojevic on 31/12/19.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case networkError
    case error(Error)
}

enum Result<Data, Error> {
    case success(Data)
    case failure(Error)
}

struct NetworkManager {
    
    static func load(with url: String, completionHandler: @escaping (Result<Data, ResponseError>) -> Void) {
        
        guard let url = URL(string: url) else {
            print("Wrong URL!")
            return
        }
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        session.dataTask(with: url) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.networkError))
                return
            }
            
            if let error = error {
                completionHandler(.failure(.error(error)))
                return
            }
            
            guard let data = data else { return }
            completionHandler(.success(data))
        }.resume()
    }
}
