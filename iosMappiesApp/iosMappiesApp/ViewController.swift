//
//  ViewController.swift
//  iosMappiesApp
//
//  Created by NandN on 8/14/16.
//  Copyright © 2016 5 O'Clock. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination: NSObject {
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name =  name
        self.location = location
        self.zoom = zoom
    
    }

}
class ViewController: UIViewController {

    var mapView: GMSMapView?
    
    var currentDestination: VacationDestination?
    
    let destinations = [VacationDestination(name: "Kamegawa: peeps here", location: CLLocationCoordinate2DMake(33.330737, 131.493015), zoom: 16), VacationDestination(name: "Mochigahama: busstop", location: CLLocationCoordinate2DMake(33.292451, 131.502795), zoom: 16)]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyCqhjGB-4fMUnSv41SfsJI6jZ6jU9agXgo")

        let camera = GMSCameraPosition.cameraWithLatitude(33.336274, longitude: 131.466965, zoom: 16)
        
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(33.336274, 131.466965)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "APU Library: So empty right now"
        marker.snippet = "Uni"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(ViewController.next))
    }
    
    func next() {
     
        if currentDestination == nil {
            currentDestination = destinations.first
            
            
            }else{
        
            if let index = destinations.indexOf(currentDestination!){
                currentDestination = destinations[index + 1]

            }
        }
        
        setMapCamera()
    }
 
    private func setMapCamera(){
        
        CATransaction.begin()
        CATransaction.setValue(1, forKey: kCATransactionAnimationDuration)
        mapView?.animateToCameraPosition(GMSCameraPosition.cameraWithTarget(currentDestination!.location, zoom: currentDestination!.zoom))
        
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        
        marker.map = mapView

    
    
    }


}

