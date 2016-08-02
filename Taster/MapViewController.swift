//
//  MapViewController.swift
//  Taster
//
//  Created by Catarina Silva on 08/04/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var food:Food?
    
    override func viewDidLoad() {
        map.delegate = self
        map.showsUserLocation = true
    }
    
    override func viewWillAppear(animated: Bool) {
        showFoodsOnMap()
    }
    
    func showFoodsOnMap () {
        var pin: CustomPin
        //map.removeAnnotations(self.map.annotations)
        for f in FoodRepository.repository.foods {
            if let loc = f.location {
                map.setRegion(MKCoordinateRegionMake(loc, MKCoordinateSpanMake(1, 1)), animated: true)
                pin = CustomPin(coordinate: loc, food:f, title: f.name, subtitle: " ")
                self.map.addAnnotation(pin)
            }
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "identifier"
        var annotationView:MKPinAnnotationView?
        
        if annotation.isKindOfClass(CustomPin) {
            
            annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                annotationView!.canShowCallout = true
                annotationView!.pinTintColor = UIColor.purpleColor()
                
                let btn = UIButton(type: .DetailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            } else {
                annotationView!.annotation = annotation
            }
            
            
            
            return annotationView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation as! CustomPin
        food = annotation.food
        self.performSegueWithIdentifier("mapFoodDetail", sender: annotation)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? FoodDetailViewController {
            controller.food = food
        }
    }
    
}


