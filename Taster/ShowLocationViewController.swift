//
//  ShowLocationViewController.swift
//  Taster
//
//  Created by Catarina Silva on 08/04/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import UIKit
import MapKit

class ShowLocationViewController: UIViewController, MKMapViewDelegate {
    var food:Food?
    var annotation = MKPointAnnotation()
    let locationManager = CLLocationManager ()

    @IBOutlet weak var map: MKMapView!
    
    @IBAction func cancelAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func navigateAction(sender: UIButton) {
        if let loc = food?.location  {
            locationManager.startUpdatingLocation()
            let latituteFood:CLLocationDegrees =  loc.latitude
            let longituteFood:CLLocationDegrees = loc.longitude
            
            let coordinate = CLLocationCoordinate2DMake(latituteFood, longituteFood)
            
            let placemark : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary:nil)
            
            let mapItem:MKMapItem = MKMapItem(placemark: placemark)
            
            
            mapItem.name = food!.name
            
            
            let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey)
            
            let currentLocationMapItem:MKMapItem = MKMapItem.mapItemForCurrentLocation()
            
            MKMapItem.openMapsWithItems([currentLocationMapItem, mapItem], launchOptions: launchOptions as? [String : AnyObject])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if let loc = food?.location {
            showLocation(loc)
        }
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
            let alertController = UIAlertController(title: "Error locating food.", message:"No location defined." , preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    func showLocation (loc:CLLocationCoordinate2D) {
        map.setRegion(MKCoordinateRegionMake(loc, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
        annotation.coordinate = loc
        annotation.title = food!.name
        annotation.subtitle = " "
        map.addAnnotation(annotation)
        
        GeonamesClient.findNearbyWikipedia(loc) { (geoWiki) in
            if geoWiki != nil {
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    self.showNearbyWikipedia(geoWiki!)
                })
            }
        }
    }

    func showNearbyWikipedia (wikiEntries : [GeonamesWikipedia]) {
        for entry in wikiEntries {
            let annotation = MKPointAnnotation()
            annotation.coordinate = entry.coordinate
            annotation.title = entry.title
            annotation.subtitle = entry.summary
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
