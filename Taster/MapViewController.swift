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
        showFoodsOnMap(FoodRepository.foods)
    }
    
    func showFoodsOnMap (foodsToAdd:[Food]) {
        var pin: CustomPin
        //        map.removeAnnotations(self.map.annotations)
        for f in FoodRepository.foods {
            if let loc = f.location {
                map.setRegion(MKCoordinateRegionMake(loc, MKCoordinateSpanMake(1, 1)), animated: true)
                pin = CustomPin(coordinate: loc, food:f, title: f.name, subtitle: " ")
                self.map.addAnnotation(pin)
            }
            
        }
        
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        let identifier = "identifier"
        
        // 2
        if annotation.isKindOfClass(CustomPin) {
            // 3
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil {
                //4
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                // 5
                let btn = UIButton(type: .DetailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            } else {
                // 6
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        // 7
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
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
