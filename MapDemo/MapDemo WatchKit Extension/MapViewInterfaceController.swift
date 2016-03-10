//
//  MapViewInterfaceController.swift
//  MapDemo
//
//  Created by Yogesh Bharate on 04/02/16.
//  Copyright © 2016 Yogesh Bharate. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation


class MapViewInterfaceController: WKInterfaceController, CLLocationManagerDelegate {

    @IBOutlet var mapView: WKInterfaceMap!
  @IBOutlet var slider: WKInterfaceSlider!
  
  
    // Variables
    var locationMgr = CLLocationManager()
    var mapLocation: CLLocationCoordinate2D?
  
  
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
      locationMgr.requestWhenInUseAuthorization()
      locationMgr.desiredAccuracy = kCLLocationAccuracyBest
      locationMgr.delegate = self
      locationMgr.requestLocation()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let currentLocation = locations[0]
    let lat = currentLocation.coordinate.latitude
    let long = currentLocation.coordinate.longitude
    
    self.mapLocation = CLLocationCoordinate2DMake(lat, long)
    print(mapLocation)
    
    let span = MKCoordinateSpanMake(0.1, 0.1)
    
    let region = MKCoordinateRegionMake(mapLocation!, span)
    
    self.mapView.setRegion(region)
    
    mapView.addAnnotation(mapLocation!, withPinColor: .Red)
  }
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print(error.localizedDescription)
  }
  
  @IBAction func changeZoomingLevel(value: Float) {
    print(value)
    let degrees : CLLocationDegrees = CLLocationDegrees(value/10)
    let span = MKCoordinateSpanMake(degrees, degrees)
    let region = MKCoordinateRegionMake(mapLocation!, span)
    mapView.setRegion(region)
    
  }

}
