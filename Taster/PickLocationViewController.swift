//
//  PickLocationViewController.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import UIKit
import CoreLocation
import MapKit

class PickLocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var location:CLLocationCoordinate2D?
    var annotation = MKPointAnnotation()
    
    var delegate: WriteValueBackDelegate?
    
    @IBAction func cancelLocation(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveLocation(_ sender: UIButton) {
        if let loc = location {
            delegate?.writeValueBack(loc)
        }
        
        self.dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func didTapMap(_ sender: UITapGestureRecognizer) {
        let tapPoint: CGPoint = sender.location(in: map)
        location = map.convert(tapPoint, toCoordinateFrom: map)

        if (location?.latitude != annotation.coordinate.latitude || location?.longitude != annotation.coordinate.longitude) {
            map.removeAnnotation(annotation)
            
            annotation.coordinate = location!
            annotation.title = "Food location"
            annotation.subtitle = " "
            map.addAnnotation(annotation)
        }
    
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "identifier"
        var annotationView:MKPinAnnotationView?
        
        if annotation.isKind(of: MKPointAnnotation.self) {
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                annotationView!.canShowCallout = true
                annotationView!.pinTintColor = UIColor.purple
                
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
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if let loc = location {
            map.setRegion(MKCoordinateRegionMake(loc, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
            
            annotation.coordinate = loc
            annotation.title = "Food location"
            annotation.subtitle = " "
            
            map.addAnnotation(annotation)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationObj = locations.last
        let coord = locationObj?.coordinate
        if let c = coord {
            map.setRegion(MKCoordinateRegionMake(c, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
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
