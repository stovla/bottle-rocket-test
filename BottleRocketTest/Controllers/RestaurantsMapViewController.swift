//
//  RestaurantsMapViewController.swift
//  BottleRocketTest
//
//  Created by Vlastimir Radojevic on 3/1/20.
//  Copyright © 2020 Vlastimir. All rights reserved.
//

import UIKit
import MapKit

class RestaurantsMapViewController: UIViewController, MKMapViewDelegate {

    // MARK: - Properties
    @IBOutlet weak var mapView: MKMapView!
    var restaurants: [Restaurant]?
    
    // MARK: - UIViewController override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(white: 0, alpha: 0)
        transitioningDelegate = self
        setupMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        perform(#selector(zoomMap), with: nil, afterDelay: animationDuration)
    }
    
    // MARK: - MapView setup
    private func setupMapView() {
        mapView.delegate = self
        guard let restaurants = restaurants else { return }
        restaurants.forEach { restaurant in
            createAnnotation(restaurant)
        }
    }
    
    private func createAnnotation(_ restaurant: Restaurant) {
        let lat = restaurant.location.lat
        let lng = restaurant.location.lng
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        annotation.title = restaurant.name
        annotation.subtitle = restaurant.location.address
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - MapView methods
    @objc private func zoomMap() {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "annotationView"
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        view.displayPriority = .required
        view.image = UIImage(named: AssetConstants.mapPointer)
        view.annotation = annotation
        view.canShowCallout = true
        return view
    }
    
    // MARK: - IBAction methods
    @IBAction func closeMapView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension RestaurantsMapViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationType: .dismiss)
    }
}
