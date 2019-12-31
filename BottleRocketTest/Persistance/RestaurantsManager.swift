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
    
    func getRestaruants() -> [Restaurant] {
        
        if let result = retreiveRestaurantsFromCache() {
            return result
        } else if let result = retrieveRestaurantsFromServer() {
            return result
        }
        return []
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
    
    private func retrieveRestaurantsFromServer() -> [Restaurant]? {
        
        var restaurants = [Restaurant]()
        
        NetworkManager.load(with: restaurantUrlString) { [weak self] response in
            switch response {
            case .success(let data):
                restaurants = self?.decodeData(data) ?? []
                self?.retreiveImagesFor(restaurants: restaurants)
            case .failure(let error):
                print(error)
            }
        }
        return restaurants
    }
    
    private func retreiveRestaurantsFromCache() -> [Restaurant]? {
        
        guard let data = CacheManager.cachedDataFrom(urlString: restaurantUrlString) else {
            return nil
        }
        return self.decodeData(data)
    }
    
    private func retreiveImagesFor(restaurants: [Restaurant]) {
        
        restaurants.forEach { restaurant in
            guard let url = restaurant.backgroundImageURL else {
                return
            }
            
            NetworkManager.load(with: url) { result in
                switch result {
                case .success(let data):
                    CacheManager.cacheData(data: data, from: url)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
