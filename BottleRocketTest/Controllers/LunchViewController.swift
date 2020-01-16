//
//  LunchViewController.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 26/12/2019.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import UIKit

private struct Identifiers {
    static let restaurantMap = "RestaurantsMap"
    static let mainBundle = "Main"
    static let collectionViewCellClass = "CollectionViewCell"
    static let cellIdentifier = "cell"
    static let segueDetailsIdentifier = "ShowDetails"
}

class LunchViewController: UICollectionViewController {
    
    private var restaurants = [Restaurant]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBAction func openMapFullScreen(_ sender: UIBarButtonItem) {
        
        let storyBoard = UIStoryboard(name: Identifiers.mainBundle, bundle: nil)
        guard let controller = storyBoard.instantiateViewController(withIdentifier: Identifiers.restaurantMap) as? RestaurantsMapViewController else { return }
        controller.restaurants = restaurants
        present(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        loadData()
    }
    
    private func setupTabBar() {
        
        let internetsVC = InternetsViewController()
        let tabBarItem = UITabBarItem(title: StringConstants.internets,
                                      image: UIImage(named: AssetConstants.tabInternets),
                                      tag: 1)
        internetsVC.tabBarItem = tabBarItem
        let internetsNavigationController = UINavigationController(rootViewController: internetsVC)
        tabBarController?.viewControllers?.append(internetsNavigationController)
    }
    
    private func loadData() {
        
        collectionView.register(UINib(nibName: Identifiers.collectionViewCellClass, bundle: nil),
                                forCellWithReuseIdentifier: Identifiers.cellIdentifier)
        RestaurantsManager.getRestaruants { restaurants in
            DispatchQueue.main.async {
                self.restaurants = restaurants
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let cell = sender as? CollectionViewCell else { return }
        guard let controller = segue.destination as? DetailsViewController else { return }
        controller.restaurant = cell.restaurant
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension LunchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var columnNumber: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 2 : 1
        // last item to fill the gap
        if !restaurants.count.isMultiple(of: 2) && indexPath.row == restaurants.count - 1 {
            columnNumber = 1
        }
        return CGSize(width: view.frame.width / columnNumber, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.cellIdentifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        let item = restaurants[indexPath.row]
        cell.restaurant = item
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: Identifiers.segueDetailsIdentifier, sender: cell)
    }
}
