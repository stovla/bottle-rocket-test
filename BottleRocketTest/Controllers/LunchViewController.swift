//
//  LunchViewController.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 26/12/2019.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import UIKit
// MARK: - Private identifiers
private struct Identifiers {
    static let restaurantMap: String = "RestaurantsMap"
    static let mainBundle: String = "Main"
    static let collectionViewCellClass: String = "CollectionViewCell"
    static let cellIdentifier: String = "cell"
    static let segueDetailsIdentifier: String = "ShowDetails"
}

class LunchViewController: UICollectionViewController {
    // MARK: - Properties
    private var restaurants: [Restaurant] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - IBAction methods
    @IBAction func openMapFullScreen(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: Identifiers.mainBundle, bundle: nil)
        guard let controller = storyBoard.instantiateViewController(withIdentifier: Identifiers.restaurantMap) as? RestaurantsMapViewController else { return }
        controller.restaurants = restaurants
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: true)
    }
    
    // MARK: - ViewController override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: Identifiers.collectionViewCellClass, bundle: nil),
        forCellWithReuseIdentifier: Identifiers.cellIdentifier)
        setupTabBar()
        loadData()
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
           collectionView.collectionViewLayout.invalidateLayout()
       }
    
    // MARK: - UI update methods
    private func setupTabBar() {
        let internetsVC = InternetsViewController()
        let tabBarItem = UITabBarItem(title: StringConstants.internets,
                                      image: UIImage(named: AssetConstants.tabInternets),
                                      tag: 1)
        internetsVC.tabBarItem = tabBarItem
        let internetsNavigationController = UINavigationController(rootViewController: internetsVC)
        tabBarController?.viewControllers?.append(internetsNavigationController)
    }
    
    // MARK: - Private API
    private func loadData() {
        RestaurantsManager.getRestaruants { restaurants in
            DispatchQueue.main.async {
                self.restaurants = restaurants
            }
        }
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? CollectionViewCell else { return }
        guard let controller = segue.destination as? DetailsViewController else { return }
        controller.restaurant = cell.restaurant
    }
   
}

// MARK: - CollectionView Delegate Methods
extension LunchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var columnNumber: CGFloat = UIDevice.current.orientation.isLandscape || UIDevice.current.userInterfaceIdiom != .phone ? 2 : 1
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
