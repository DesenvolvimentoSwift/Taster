//
//  ShowLocationViewController.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import UIKit
import MapKit

class ShowLocationViewController: UIViewController, MKMapViewDelegate {
    var food:Food?
   // var annotation = MKPointAnnotation()
    let locationManager = CLLocationManager ()

    @IBOutlet weak var map: MKMapView!
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func navigateAction(_ sender: UIButton) {
        if let loc = food?.location  {
            locationManager.startUpdatingLocation()
            let latituteFood:CLLocationDegrees =  loc.latitude
            let longituteFood:CLLocationDegrees = loc.longitude
            
            let coordinate = CLLocationCoordinate2DMake(latituteFood, longituteFood)
            
            let placemark : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary:nil)
            
            let mapItem:MKMapItem = MKMapItem(placemark: placemark)
            
            
            mapItem.name = food!.name
            
            
            let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)
            
            let currentLocationMapItem:MKMapItem = MKMapItem.forCurrentLocation()
            
            MKMapItem.openMaps(with: [currentLocationMapItem, mapItem], launchOptions: launchOptions as? [String : AnyObject])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        map.showsUserLocation = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let loc = food?.location {
            showLocation(loc)
        }
//Esta parte deixou de ser precisa, pois é feita logo no insert
        else if let local = food?.local {
            
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(local, completionHandler: { (placemarks, error) in
                self.food?.location = placemarks?.first?.location?.coordinate
                if let loc = self.food?.location {
                    self.showLocation(loc)
                }
            })
        }
        else {
            let alertController = UIAlertController(title: "Error locating food.", message:"No location defined." , preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func showLocation (_ loc:CLLocationCoordinate2D) {
        
        var pin:CustomPin
        
        map.setRegion(MKCoordinateRegionMake(loc, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
        pin = CustomPin(coordinate: loc, food:food!, title: food!.name, subtitle: " ")
        map.addAnnotation(pin)
        
        GeonamesClient.findNearbyWikipedia(loc) { (geoWiki) in
            if geoWiki != nil {
                OperationQueue.main.addOperation({ 
                    self.showNearbyWikipedia(geoWiki!)
                })
            }
        }

        GeonamesClient.findNearbyPOI(loc, completionHandler: { (POIs) in
            if POIs != nil {
                self.showNearbyPOI(POIs!)
            }
        })

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
                
            } else {
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        else if annotation.isKind(of: WikipediaPin.self) {
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "wikiPin") as? MKPinAnnotationView
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "wikiPin")
                
                annotationView!.canShowCallout = true
                annotationView!.pinTintColor = UIColor.green
                
            } else {
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let wikiPin = view.annotation as? WikipediaPin {
            if let url = wikiPin.geoWiki.url {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    func showNearbyWikipedia (_ wikiEntries : [GeonamesWikipedia]) {
        for entry in wikiEntries {
            let wikiPin = WikipediaPin(geoWiki: entry)
            map.addAnnotation(wikiPin)
        }
    }
    
    func showNearbyPOI (_ poiEntries : [GeonamesPOI]) {
        for entry in poiEntries {
            let annotation = MKPointAnnotation()
            annotation.coordinate = entry.coordinate
            annotation.title = entry.name
            annotation.subtitle = entry.typeName
            map.addAnnotation(annotation)
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
