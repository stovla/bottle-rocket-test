//
//  RestaurantsNetworkManager.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 28/12/2019.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import Foundation

struct RestaurantsNetworkManager {
    
    func getAllRestaurants(_ completion: @escaping ([Restaurant]) -> Void) {
        
        guard let url = URL(string: restaurantUrlString) else {
            print("Wrong URL!")
            return
        }
        
        URLSession.shared.restaurantsTask(with: url) { (restaurants, response, error) in
            guard let restaurants = restaurants, (response as? HTTPURLResponse)?.statusCode == 200, error == nil else {
                if let error = error {
                    print("Failed to return the list of restaurants\nError:\(error.localizedDescription)")
                }
                return
            }
            completion(restaurants.restaurants)
        }.resume()
    }
}

extension URLSession {
    
    fileprivate func codableTask<T: Decodable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error);
                return
            }
            // using do/try/catch to make sure if there are any missing properties
            do {
                let restaurants = try JSONDecoder().decode(T.self, from: data)
                completionHandler(restaurants, response, nil)
            } catch {
                print(error)
            }
        }
    }
    
    func restaurantsTask(with url: URL, completionHandler: @escaping (Restaurants?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
