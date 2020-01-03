//
//  RestaurantsManager.swift
//  BottleRocketTest
//
//  Created by Vlastimir Radojevic on 31/12/19.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import Foundation

let restaurantUrlString = "https://s3.amazonaws.com/br-codingexams/restaurants.json"

struct RestaurantsManager {
    
    static func getRestaruants(_ completion: @escaping ([Restaurant]) -> Void) {
        
        if let data = CacheManager.cachedDataFrom(urlString: restaurantUrlString) {
            do {
                let result = try JSONDecoder().decode(Restaurants.self, from: data)
                CacheManager.cacheData(data: data, from: restaurantUrlString)
                completion(result.restaurants)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        } else {
            NetworkManager.load(with: restaurantUrlString) { response in
                switch response {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(Restaurants.self, from: data)
                        CacheManager.cacheData(data: data, from: restaurantUrlString)
                        completion(result.restaurants)
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
