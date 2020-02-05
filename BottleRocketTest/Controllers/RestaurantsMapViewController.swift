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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spanMap()
    }
    
    // MARK: create annotation for each restaurant
    private func setupMapView() {
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
    
    private func zoomMap(_ location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion (center: location.coordinate, span: span)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    // MARK: zooming the map
    private func spanMap() {
        guard let first = restaurants?.first else { return }
        let coordinates = CLLocationCoordinate2D(latitude: first.location.lat, longitude: first.location.lng)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion (center: coordinates, span: span)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    @IBAction func closeMapView(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
