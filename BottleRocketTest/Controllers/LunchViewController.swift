//
//  LunchViewController.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 26/12/2019.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import UIKit

class LunchViewController: UIViewController {
    
    private var restaurants = [Restaurant]()
    let manager = RestaurantsNetworkManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource = UICollectionViewDiffableDataSource<Section, Restaurant>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let restMng = RestaurantsNetworkManager()
        restMng.getAllRestaurants { restaurants in
            restaurants.forEach { restaurant in
                print(restaurant)
            }
        }
    }
    
    private func configureDataSource() {
        collectionView.dataSource = dataSource;
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, restaurant) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            // cell data

            return cell
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LunchViewController {
    fileprivate enum Section {
        case main
    }
}
