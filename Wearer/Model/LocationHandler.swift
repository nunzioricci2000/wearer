//
//  LocationHandler.swift
//  Wearer
//
//  Created by Nunzio Ricci on 20/01/23.
//

import Foundation
import CoreLocation

class LocationHandler {
    static var shared: LocationHandler = LocationHandler()
    var manager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    var geocoder = CLGeocoder()
    
    /// Return current location
    func getLocation() async throws -> CLLocation {
        if let location = manager.location {
            return location
        }
        throw LocationError.nilLocation
    }
    
    /// Return current location name
    func getLocationName(of location: CLLocation?) async throws -> String {
        guard let location = location else {
            return try await getLocationName(of: getLocation())
        }
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        guard let placemark = placemarks.first else {
            throw LocationError.nonExistentPlacemark
        }
        guard let locationName = placemark.locality else {
            throw LocationError.unnamedLocality
        }
        return locationName
    }
}

enum LocationError: Error {
    case nilLocation
    case nonExistentPlacemark
    case unnamedLocality
}
