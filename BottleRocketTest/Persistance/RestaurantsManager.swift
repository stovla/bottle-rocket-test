//
//  RestaurantsManager.swift
//  BottleRocketTest
//
//  Created by Vlastimir Radojevic on 31/12/19.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import Foundation

let restaurantUrlString = "https://s3.amazonaws.com/br-codingexams/restaurants.json"

class RestaurantsManager {
    
    func getRestaruants(_ completion: @escaping ([Restaurant]) -> Void) {
        
        if let result = retreiveRestaurantsFromCache() {
            completion(result)
            return
        }
        
        NetworkManager.load(with: restaurantUrlString) { [weak self] response in
            switch response {
            case .success(let data):
                let restaurants = self?.decodeData(data) ?? []
                completion(restaurants)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
        
    }
    
    private func decodeData(_ data: (Data)) -> [Restaurant]? {
        
        do {
            let result = try JSONDecoder().decode(Restaurants.self, from: data)
            CacheManager.cacheData(data: data, from: restaurantUrlString)
            return result.restaurants
        } catch {
            print(error)
            return nil
        }
    }
    
    private func retreiveRestaurantsFromCache() -> [Restaurant]? {
        
        guard let data = CacheManager.cachedDataFrom(urlString: restaurantUrlString) else {
            return nil
        }
        return self.decodeData(data)
    }
}
