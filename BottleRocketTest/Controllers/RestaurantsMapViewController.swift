//
//  RestaurantsMapViewController.swift
//  BottleRocketTest
//
//  Created by Vlastimir Radojevic on 3/1/20.
//  Copyright © 2020 Vlastimir. All rights reserved.
//

import UIKit
import MapKit

class RestaurantsMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dismissButton: UIButton!
    
    var restaurants: [Restaurant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButton.layer.cornerRadius = 10
        setupMapView()
    }
    
    private func setupMapView() {
        guard let restaurants = restaurants else { return }
        
        restaurants.forEach { restaurant in
            createAnnotation(restaurant)
        }
        
        guard let first = restaurants.first else { return }
        spanMap(location: first.location)
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
    
    private func spanMap(location: RestaurantLocation) {
        
        let coordinates = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion (center: coordinates, span: span)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    @IBAction func closeMapView(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
