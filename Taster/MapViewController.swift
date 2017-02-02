//
//  MapViewController.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
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
    
    override func viewWillAppear(_ animated: Bool) {
        showFoodsOnMap()
    }
    
    func showFoodsOnMap () {
        //map.removeAnnotations(self.map.annotations)
        for f in FoodRepository.repository.foods {
            if let loc = f.location {
                map.setRegion(MKCoordinateRegionMake(loc, MKCoordinateSpanMake(1, 1)), animated: true)
                let pin = CustomPin(coordinate: loc, food:f, title: f.name, subtitle: " ")
                self.map.addAnnotation(pin)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "identifier"
        var annotationView:MKPinAnnotationView?
        
        if annotation.isKind(of: CustomPin.self) {
            
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                annotationView!.canShowCallout = true
                annotationView!.pinTintColor = UIColor.purple
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            } else {
                annotationView!.annotation = annotation
            }
            
            
            
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation as! CustomPin
        food = annotation.food
        self.performSegue(withIdentifier: "mapFoodDetail", sender: annotation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FoodDetailViewController {
            controller.food = food
        }
    }
    
}


