//
//  OtherViewController.swift
//  ParkIt
//
//  Created by Vishnu Thiagarajan on 9/26/15.
//  Copyright © 2015 Vishnu Thiagarajan. All rights reserved.
//

import Foundation


import UIKit
import MapKit
import CoreLocation

class OtherViewController: UIViewController,CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var notes: UITextField!
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
    
    @IBAction func finished(sender: AnyObject) {
        let storage: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var all:NSMutableArray = NSMutableArray()
        
        if(storage.objectForKey("all") != nil){
            all=storage.objectForKey("all")?.mutableCopy() as! NSMutableArray
        }
        
        let x: NSMutableArray = NSMutableArray()
        x.addObject("bike")
        x.addObject(" ")
        if(notes.text != nil){
            x.addObject(notes.text!)}
        else{
            x.addObject(" ")
        }
        let fm = NSDateFormatter()
        fm.dateFormat = "HH:mm:ss"
        let str: String = fm.stringFromDate(NSDate())
        
        print(loc)
        print(loc.location)
        x.addObject(NSKeyedArchiver.archivedDataWithRootObject(loc.location!))

        x.addObject(str)
        
        all.addObject(x)
        storage.setObject(all, forKey: "all")
        
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
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("didFailWithError: \(error.description)")
        //let errorAlert = UIAlertController(title: "Error", message: "Failed to Get Your Location", preferredStyle: UIAlertControllerStyle(rawValue: 1)!)
    }
    
    /*   func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) { // Updated to current array syntax [AnyObject] rather than AnyObject[]
    print("locations = \(locations)")
    }*/
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
        print(mapView.userLocation)
        loc = mapView.userLocation
    }
    
    
}