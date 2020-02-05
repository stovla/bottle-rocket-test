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
    
    @IBOutlet weak var mapViewHeightConstraint: NSLayoutConstraint!
    
    var restaurant: Restaurant?
    private var isMapExtended: Bool = false
    var location = CLLocation();
    
    @IBAction func showFullMap(_ sender: UIBarButtonItem) {
        expandMap(!isMapExtended)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        zoomMap(location)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // updating text color whether we are using dark theme
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextColor), name: UIApplication.didBecomeActiveNotification, object: nil)
        updateTextColor()
    }
    
    private func updateViews() {
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
    
    // MARK: updating colors based on the dark/light mode on the device
    @objc private func updateTextColor() {
        let isDarkMode: Bool = traitCollection.userInterfaceStyle == .dark
        restaurantAddressPart1.textColor = isDarkMode ? .white : .appColor(.textLabelDark)
        restaurantAddressPart2.textColor = isDarkMode ? .white : .appColor(.textLabelDark)
        restaurantPhone.textColor = isDarkMode ? .white : .appColor(.textLabelDark)
        restaurantSocialHandler.textColor = isDarkMode ? .white : .appColor(.textLabelDark)
        view.backgroundColor = isDarkMode ? .appColor(.tabBarDark) : .white
    }
    
    // MARK: MapView methods
    private func setupMapView() {
        guard let lat = restaurant?.location.lat, let long = restaurant?.location.lng else { return }
        location = CLLocation(latitude: lat, longitude: long)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapView.addAnnotation(annotation)
    }
    
    private func zoomMap(_ location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion (center: location.coordinate, span: span)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    private func expandMap(_ expand: Bool) {
        isMapExtended = expand
        UIView.animate(withDuration: 0.5) {
            self.mapViewHeightConstraint.priority = UILayoutPriority(expand ? 500 : 1000)
            self.view.layoutIfNeeded()
        }
    }
}
