//
//  PickLocationViewController.swift
//  Taster
//
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol writeValueBackDelegate {
    func writeValueBack(value: CLLocationCoordinate2D?)
}

class PickLocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var location:CLLocationCoordinate2D?
    var currentLocation = CLLocationCoordinate2D()
    var locationSet = false
    var annotation = MKPointAnnotation()
    
    var delegate: writeValueBackDelegate?
    
    @IBAction func cancelLocation(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func saveLocation(sender: UIButton) {
        if let loc = location {
            delegate?.writeValueBack(loc)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    @IBAction func didTapMap(sender: UITapGestureRecognizer) {
        let tapPoint: CGPoint = sender.locationInView(map)
        location = map.convertPoint(tapPoint, toCoordinateFromView: map)

        if (location?.latitude != annotation.coordinate.latitude || location?.longitude != annotation.coordinate.longitude) {
            map.removeAnnotation(annotation)
            
            annotation.coordinate = location!
            annotation.title = "Food location"
            annotation.subtitle = " "
            map.addAnnotation(annotation)
        }
    
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "identifier"
        var annotationView:MKPinAnnotationView?
        
        if annotation.isKindOfClass(MKPointAnnotation) {
            annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                annotationView!.canShowCallout = true
                annotationView!.pinTintColor = UIColor.purpleColor()
                
            } else {
                annotationView!.annotation = annotation
            }
            
            
            
            return annotationView
        }
        return nil
    }
    
    override func viewDidLoad() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        
        map.delegate = self
        map.showsUserLocation = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        if let loc = location {
            map.setRegion(MKCoordinateRegionMake(loc, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
            
            annotation.coordinate = loc
            annotation.title = "Food location"
            annotation.subtitle = " "
            
            map.addAnnotation(annotation)
        }
        else {
             map.setRegion(MKCoordinateRegionMake(currentLocation, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationObj = locations.last
        let coord = locationObj?.coordinate
        if let c = coord {
            currentLocation = c
            if !locationSet {
                locationSet = true
                map.setRegion(MKCoordinateRegionMake(currentLocation, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
