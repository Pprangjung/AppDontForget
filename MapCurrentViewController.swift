//
//  MapCurrentViewController.swift
//  AppDontForget
//
//  Created by Prang on 3/21/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit
import MapKit

class MapCurrentViewController: UIViewController,CLLocationManagerDelegate {

    var coreLocationManger = CLLocationManager()
    var locationManager:LocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
   
    @IBOutlet weak var locationInfo: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

         coreLocationManger.delegate = self
         locationManager = LocationManager.sharedInstance
        
        let authorizationCode = CLLocationManager.authorizationStatus()
        if authorizationCode == CLAuthorizationStatus.notDetermined && coreLocationManger.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization)) || coreLocationManger.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
            if Bundle.main.infoDictionary?["NSLocationAlwaysUsageDescription"] as? String  != nil{
                
                coreLocationManger.requestAlwaysAuthorization()
            
            }else{
             
                print("No description provided")
            
            }
        
        }
        
        else{
            
            getLocation()
        
           }
        }
        
    
    
    
    
    
    
    
        
    func getLocation(){
    
        locationManager.startUpdatingLocationWithCompletionHandler{(latitude,longitude,status,verboseMessage,Error)->()in
            self.displayLocation(location: CLLocation(latitude:latitude,longitude:longitude))
        
        }
    
    
    }
    
    
    func displayLocation(location:CLLocation)
    {
    
        mapView.setRegion(MKCoordinateRegion(center:CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude),span:MKCoordinateSpanMake(0.05,0.05)),animated:true )
    
        let locationPincord = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPincord
        
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
        locationManager.reverseGeocodeLocationWithCoordinates(location,onReverseGeocodingCompletionHandler: {(reverseGecodeInfo,placemarks, error) -> Void in
            
            let address = reverseGecodeInfo?.object(forKey: "formattedAddress")as! String
            self.locationInfo.text = address
        
        
        })
    
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != CLAuthorizationStatus.notDetermined || status != CLAuthorizationStatus.denied || status != CLAuthorizationStatus.restricted {
         getLocation()
        
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func updateLocation(_ sender: Any) {
        getLocation()
    }
   

}
