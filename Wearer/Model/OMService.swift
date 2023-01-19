//
//  OpenMeteo.swift
//  Wearer
//
//  Created by Nunzio Ricci on 16/01/23.
//

// swiftlint:disable all

import Foundation
import CoreLocation // For coordinates

public final class OMService: NSObject, ObservableObject {

    private var completionHandler: ((Weather?, LocationAuthError?) -> Void)?
    private var dataTask: URLSessionDataTask?
    private let locationManager = CLLocationManager()
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func loadWeatherData(_ completionHandler: @escaping(Weather?, LocationAuthError?) -> Void) {
        self.completionHandler = completionHandler
        loadDataOrRequestLocationAuth()
    }
    
    // Current Weather API: https://api.open-meteo.com/v1/forecast?latitude=40.85&longitude=14.26&current_weather=true
    
    func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        //guard let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)&hourly=temperature_2m"
            //.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)&current_weather=true"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else { return }
        guard let url = URL(string: urlString)
        else { return }
        
        dataTask?.cancel()
        
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            
            if let response = try? JSONDecoder().decode(OMResponse.self, from: data) {
                self.completionHandler?(Weather(response: response), nil)
            }
        }
        
        dataTask?.resume()
    }
    
    private func loadDataOrRequestLocationAuth() {
      switch locationManager.authorizationStatus {
      case .authorizedAlways, .authorizedWhenInUse:
        locationManager.startUpdatingLocation()
      case .denied, .restricted:
        completionHandler?(nil, LocationAuthError())
      default:
        locationManager.requestWhenInUseAuthorization()
      }
    }
}

extension OMService: CLLocationManagerDelegate {
  
    public func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
  ) {
    guard let location = locations.first else { return }
    makeDataRequest(forCoordinates: location.coordinate)
  }

  public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    loadDataOrRequestLocationAuth()
  }
  public func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print("Something went wrong: \(error.localizedDescription)")
  }
}

public struct LocationAuthError: Error{}
