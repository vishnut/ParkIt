//
//  CellViewController.swift
//  ParkIt
//
//  Created by Vishnu Thiagarajan on 9/27/15.
//  Copyright © 2015 Vishnu Thiagarajan. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class CellViewController: UIViewController,CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MKMapViewDelegate{

    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var ps:String = "S"
    var nt:String = "S"
    var tm:String = "S"
    var lc:CLLocation = CLLocation()
    let messageComposer = MessageComposer()
    
    @IBAction func openMapsApp(sender: AnyObject) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = lc.coordinate
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Parking Location"
        mapItem.openInMapsWithLaunchOptions(options)
    }
    
    @IBAction func sendText(sender: AnyObject) {
        // Make sure the device can send text messages
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } //else {
            // Let the user know if his/her device isn't able to send text messages
            //let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            //errorAlert.show()
        //}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        }
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.01 , 0.01)
        let location:CLLocationCoordinate2D = lc.coordinate
        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
        
        mapView.setRegion(theRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Parking Location"
        if(nt != "S"){
        annotation.subtitle = nt}
        mapView.addAnnotation(annotation)
        updatevalues(ps, n: nt, t: tm)
        /*if(tm != "S"){
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let date = dateFormatter.dateFromString(tm)
        }*/
    }
    
    func updatevalues(p:String,n:String,t:String){
        
        position.text =  ps
        notes.text = nt
        time.text = " "
        
        mapView.showsUserLocation = true
    }
    
    func changesn(st: String,n:String,t:String,m:NSData){
        if(t != "THIS IS A BIKE"){
        ps = "Position: " + st
        nt = "Notes: " + n
        tm = "Time: " + t
        }
        else{
            ps = " "
            nt = "Notes: " + n
            tm = " "
        }
        lc = NSKeyedUnarchiver.unarchiveObjectWithData(m as NSData) as! CLLocation
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
        print(mapView.userLocation)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("didFailWithError: \(error.description)")
        //let errorAlert = UIAlertController(title: "Error", message: "Failed to Get Your Location", preferredStyle: UIAlertControllerStyle(rawValue: 1)!)
    }
    
}