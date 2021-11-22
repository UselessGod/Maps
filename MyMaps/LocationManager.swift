//
//  LocationManager.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 21.11.2021.
//

import Foundation
import CoreLocation
import RxSwift

class LocationManager:  NSObject {
    static let shared = LocationManager()
    
    private override init() {
        super.init()
        
    }
    
    let locationManager = CLLocationManager()
    let location = PublishSubject<CLLocation?>()
    
    func startUpdating() {
        locationManager.startUpdatingHeading()
    }
    
    func stopUpdating() {
        locationManager.stopUpdatingHeading()
    }
    
    private func config() {
    
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager .delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        self.location.onNext(location)        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
