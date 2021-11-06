//
//  ViewController.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 03.11.2021.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController {
    
    private var marker: GMSMarker?
    private var manualMarker: GMSMarker?
    private var locationManager: CLLocationManager?
    private let coordinate = CLLocationCoordinate2DMake(48.700001, 44.516660)
    private let geoDecoder = CLGeocoder()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureMap()
        configureCL()
        
        let fuji = "Fuji"
        geoDecoder.geocodeAddressString(fuji) { places, error in
            print(places?.first)
        }
        
//        configureMapStyle()
    }
    
    private func configureMap() {
        let camera = GMSCameraPosition(target: coordinate, zoom: 15)
        mapView.camera = camera
//        mapView.isTrafficEnabled = true
    }
    
    private func configureCL() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        
    }
    
    private func mark() {
        marker = GMSMarker(position: coordinate)
        marker?.icon = GMSMarker.markerImage(with: .blue)
        marker?.title = "\((marker?.position.latitude)!)"
        marker?.snippet = "\((marker?.position.longitude)!)"
        marker?.map = mapView
    }
    
    private func removeMarker(){
        marker?.map = nil
        marker = nil
    }
    
    @IBAction func putMark(_ sender: Any){
        marker == nil ? mark() : removeMarker()
        
    }
    
    @IBAction func goToCenter(_ sender: Any) {
        mapView.animate(toLocation: coordinate)
    }
    
    @IBAction func updateLocation(_ sender: Any) {
        locationManager?.startUpdatingLocation()
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        locationManager?.requestLocation()
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if let manualMarker = manualMarker {
            manualMarker.position = coordinate
            mapView.animate(toLocation: coordinate)
            self.manualMarker = marker
        } else {
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            mapView.animate(toLocation: coordinate)
            manualMarker = self.marker
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        geoDecoder.reverseGeocodeLocation(location) { places, error in
            print (places?.first)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension ViewController {
    func configureMapStyle() {
            let style = "[" +
                "  {" +
                "    \"featureType\": \"all\"," +
                "    \"elementType\": \"geometry\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#242f3e\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"all\"," +
                "    \"elementType\": \"labels.text.stroke\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"lightness\": -80" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"administrative\"," +
                "    \"elementType\": \"labels.text.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#746855\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"administrative.locality\"," +
                "    \"elementType\": \"labels.text.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#d59563\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"poi\"," +
                "    \"elementType\": \"labels.text.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#d59563\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"poi.park\"," +
                "    \"elementType\": \"geometry\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#263c3f\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"poi.park\"," +
                "    \"elementType\": \"labels.text.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#6b9a76\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"road\"," +
                "    \"elementType\": \"geometry.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#2b3544\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"road\"," +
                "    \"elementType\": \"labels.text.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#9ca5b3\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"road.arterial\"," +
                "    \"elementType\": \"geometry.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#38414e\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"road.arterial\"," +
                "    \"elementType\": \"geometry.stroke\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#212a37\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"road.highway\"," +
                "    \"elementType\": \"geometry.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#746855\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"road.highway\"," +
                "    \"elementType\": \"geometry.stroke\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#1f2835\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"road.highway\"," +
                "    \"elementType\": \"labels.text.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#f3d19c\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"road.local\"," +
                "    \"elementType\": \"geometry.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#38414e\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"road.local\"," +
                "    \"elementType\": \"geometry.stroke\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#212a37\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"transit\"," +
                "    \"elementType\": \"geometry\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#2f3948\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"transit.station\"," +
                "    \"elementType\": \"labels.text.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#d59563\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"water\"," +
                "    \"elementType\": \"geometry\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#17263c\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"water\"," +
                "    \"elementType\": \"labels.text.fill\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"color\": \"#515c6d\"" +
                "      }" +
                "    ]" +
                "  }," +
                "  {" +
                "    \"featureType\": \"water\"," +
                "    \"elementType\": \"labels.text.stroke\"," +
                "    \"stylers\": [" +
                "      {" +
                "        \"lightness\": -20" +
                "      }" +
                "    ]" +
                "  }" +
            "]"
            do {
                mapView.mapStyle = try GMSMapStyle(jsonString: style)
            } catch {
                print(error)
            }
            
        }


}

