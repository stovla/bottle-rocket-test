//
//  DetailsViewController.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 02/01/2020.
//  Copyright © 2020 Vlastimir. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantCategory: UILabel!
    @IBOutlet weak var restaurantAddressPart1: UILabel!
    @IBOutlet weak var restaurantAddressPart2: UILabel!
    @IBOutlet weak var restaurantPhone: UILabel!
    @IBOutlet weak var restaurantSocialHandler: UILabel!
    
    var restaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupMapView()
    }
    
    private func setupViews() {
        restaurantPhone.text = ""
        restaurantSocialHandler.text = ""
        guard let restaurant = restaurant else { return }
        restaurantName.text = restaurant.name
        restaurantCategory.text = restaurant.category
        restaurantAddressPart1.text = restaurant.location.formattedAddress[0]
        restaurantAddressPart2.text = restaurant.location.formattedAddress[1]
        guard let contact = restaurant.contact else { return }
        restaurantPhone.text = contact.formattedPhone
        
        if let facebookName = contact.facebookName {
            restaurantSocialHandler.text = "@\(facebookName)"
        }
        
        if let twitter = contact.twitter {
            restaurantSocialHandler.text = "@\(twitter)"
        }
    }
    
    private func setupMapView() {
        guard let lat = restaurant?.location.lat, let long = restaurant?.location.lng else { return }
        
        let restaurantLocation = MKPointAnnotation()
        restaurantLocation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapView.addAnnotation(restaurantLocation)
    }
}
