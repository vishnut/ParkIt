//
//  TableController.swift
//  ParkIt
//
//  Created by Vishnu Thiagarajan on 9/26/15.
//  Copyright © 2015 Vishnu Thiagarajan. All rights reserved.
//

import Foundation
//
//  TableController.swift
//  Registration
//
//  Created by Vishnu Thiagarajan on 7/31/15.
//  Copyright © 2015 Vishnu Thiagarajan. All rights reserved.
//

import Foundation
import UIKit

class TableController: UITableViewController{
    
    //var users:NSMutableDictionary = NSMutableDictionary()
    var all:NSMutableArray = NSMutableArray()
    let storage: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var r = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let storage: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if(storage.objectForKey("users") != nil)
        {
        users = storage.objectForKey("users") as! NSMutableDictionary
        }*/
        if(storage.objectForKey("all") != nil)
        {
            all = storage.objectForKey("all")?.mutableCopy() as! NSMutableArray
        }
        // Reload the table
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.all.count
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            all.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.numberOfLines = 5
        let item:NSMutableArray = self.all[indexPath.row] as! NSMutableArray
        
        // Configure the cell
        if(item.count > 1){
            print(item.count)
            print(item)
            if((item.objectAtIndex(0) as! String) == "car"){
                //cell.textLabel?.text = "Car"
               // let dateFormatter = NSDateFormatter()
                //dateFormatter.dateFormat = "HH:mm:ss"
                //let date = dateFormatter.dateFromString((item.objectAtIndex(5) as? String)!)
                cell.textLabel?.text = "Car\n Created at " + (item.objectAtIndex(5) as! String)
                /*cell.textLabel!.text = "Type: " + (item.objectAtIndex(0) as! String) + "\nPosition: " + (item.objectAtIndex(1) as! String) + "\nNotes: " + (item.objectAtIndex(2) as! String) + "\nTimer: "
                if((item.objectAtIndex(4) as! Bool)){
                    cell.textLabel!.text = cell.textLabel!.text! + "\nTimer: " + ((item.objectAtIndex(5)) as! String)
                }*/
            }
            else{
                cell.textLabel?.text = "Bike\n Created at " + (item.objectAtIndex(4) as! String)
                //cell.textLabel!.text = "Type: " + (item.objectAtIndex(0) as! String) + "\nNotes: " + (item.objectAtIndex(2) as! String)
            }
//var lc = NSKeyedUnarchiver.unarchiveObjectWithData(detail.valueForKey!("location") as NSData) as CLLocation
                
                /*cell.textLabel!.text = "Type: " + (item.objectAtIndex(0) as! String) + "\nPosition: " + (item.objectAtIndex(1) as! String) + "\nNotes: " + (item.objectAtIndex(2) as! String)
                cell.textLabel!.text = cell.textLabel!.text! + "\nLocation: " + ((item.objectAtIndex(3)) as! String)
                var n = 5
                if((item.objectAtIndex(4) as! UISwitch).on){
                    n++
                    cell.textLabel!.text = cell.textLabel!.text! + "\nTimer: " + ((item.objectAtIndex(n)) as! String)
                }
                //if(item.objectAtIndex(n) != nil){
                    cell.textLabel!.text = cell.textLabel!.text! + "\nPicture: " + ((item.objectAtIndex(n)) as! String)
                //}*/
            
            /*
            
            cell.textLabel!.text = "Type: " + (item.objectAtIndex(0) as! String) + "\nEmail: " + (item.objectAtIndex(1) as! String) + "\nPhone: " + (item.objectAtIndex(2) as! String) + "\nDate: "
            let dates: NSMutableArray = item.objectAtIndex(4) as! NSMutableArray
            for(var de = 0; de < dates.count; de++){
                cell.textLabel!.text = cell.textLabel!.text! + (dates.objectAtIndex(de) as? String)! + " "*/
            
            
            //cell.textLabel!.text += (user.objectAtIndex(4) as! NSMutableArray)
            
        }
        else{
            cell.textLabel!.text = "Nothing to see here"
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        r = indexPath.row
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController is CellViewController){
        let mp = segue.destinationViewController as! CellViewController
        let item:NSMutableArray = self.all[r] as! NSMutableArray
            if((item.objectAtIndex(0) as! String) == "car"){
            mp.changesn((item.objectAtIndex(1) as? String)!, n: (item.objectAtIndex(2) as? String)!,t: (item.objectAtIndex(5) as? String)!, m: (item.objectAtIndex(3) as? NSData)!)
            }
            else{
                mp.changesn((item.objectAtIndex(1) as? String)!, n: (item.objectAtIndex(2) as? String)!,t: "THIS IS A BIKE", m: (item.objectAtIndex(3) as? NSData)!)
            }
            //mp.position!.text = item.objectAtIndex(1) as? String
            //mp.notes!.text = item.objectAtIndex(2) as? String
            //mp.time!.text = item.objectAtIndex(5) as? String
       // mp.updatevalues(item.objectAtIndex(1) as! String, n: item.objectAtIndex(2) as! String, t: item.objectAtIndex(5) as! String)
        }

    }
    
}