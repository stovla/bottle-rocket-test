//
//  LunchViewController.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 26/12/2019.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import UIKit

class LunchViewController: UICollectionViewController {
    
    private var restaurants = [Restaurant]()
    private let restaurantManager = RestaurantsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Lynch Tyme"
        navigationController?.navigationBar.tintColor = .white
        collectionView.backgroundColor = UIColor(named: "MainBrandColor")
        
        setupTabBar()
        loadData()
    }
    
    private func setupTabBar() {
        guard let font = UIFont.init(name: "AvenirNext-Regular", size: 10) else { return }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        let internetsVC = InternetsViewController()
        let tabBarItem = UITabBarItem(title: "internets", image: UIImage(named: "tab_internets"), tag: 1)
        internetsVC.tabBarItem = tabBarItem
        tabBarController?.viewControllers?.append(internetsVC)
    }
    
    private func loadData() {
        collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        DispatchQueue.global().async {
            do {
                guard let url = URL(string: restaurantUrlString) else { return }
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                let result = try decoder.decode(Restaurants.self, from: data)
                
                DispatchQueue.main.async { [weak self] in
                    self?.restaurants = result.restaurants
                    print(result.restaurants)
                    self?.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let cell = sender as? RestaurantCollectionViewCell else { return }
        guard let controller = segue.destination as? DetailsViewController else { return }
        controller.restaurant = cell.restaurant
    }
}

extension LunchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.bounds.size.width / 2, height: 180)
        } else if UIDevice.current.userInterfaceIdiom == .phone {
            return CGSize(width: collectionView.bounds.size.width, height: 180)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RestaurantCollectionViewCell
        let item = restaurants[indexPath.row]
        cell.restaurant = item
        if let imageURL = restaurants[indexPath.row].backgroundImageURL {
            cell.downloadImageFrom(urlString: imageURL)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: "ShowDetails", sender: cell)
    }
}
