//
//  CarViewController.swift
//  ParkIt
//
//  Created by Vishnu Thiagarajan on 9/26/15.
//  Copyright © 2015 Vishnu Thiagarajan. All rights reserved.
//

import Foundation


import UIKit
import MapKit
import CoreLocation

class CarViewController: UIViewController, CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var position: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var alerts: UISwitch!
    @IBOutlet weak var timer: UIDatePicker!
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var loc:MKUserLocation = MKUserLocation()
    var imagePicker: UIImagePickerController!
    var img:UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
            
        }


        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        img = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
    }
    
    
    @IBAction func finished(sender: AnyObject) {
        let storage: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var all:NSMutableArray = NSMutableArray()
        
        if(storage.objectForKey("all") != nil){
            all=storage.objectForKey("all")?.mutableCopy() as! NSMutableArray
        }
        
        let x: NSMutableArray = NSMutableArray()
        x.addObject("car")
        if(position.text != nil){
            x.addObject(position.text!)}
        else{
            x.addObject("")
        }
        if(notes.text != nil){
            x.addObject(notes.text!)}
        else{
            x.addObject("")
        }
        print(loc)
        print(loc.location)
        x.addObject(NSKeyedArchiver.archivedDataWithRootObject(loc.location!))
        x.addObject(alerts.on)
        let time = timer.date
        let notification:UILocalNotification = UILocalNotification()
        notification.category = "Parking Meter Alert"
        notification.alertAction = "Find your car"
        notification.alertBody = "Yo car gonna get towed"
        notification.fireDate = time
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        let fm = NSDateFormatter()
        fm.dateFormat = "HH:mm:ss"
        let str: String = fm.stringFromDate(NSDate())
        print(str)
        if(alerts.on){
            x.addObject(str)
        }
        
        //x.addObject(UIImagePNGRepresentation(img, 1.0)!)
        all.addObject(x)
        storage.setObject(all, forKey: "all")
        
    }
    
   func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("didFailWithError: \(error.description)")
        //let errorAlert = UIAlertController(title: "Error", message: "Failed to Get Your Location", preferredStyle: UIAlertControllerStyle(rawValue: 1)!)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
        loc = mapView.userLocation
        //let spanX = 0.007
        //let spanY = 0.007
        //let newRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        //mapView.setRegion(newRegion, animated: true)
       /* let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.01 , 0.01)

        print(mapView.userLocation)
        loc = mapView.userLocation
        let location:CLLocationCoordinate2D = loc.coordinate
        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
        
//        mapView.setRegion(theRegion, animated: true)
*/
        
        
    }
    
    
}