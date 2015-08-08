//
//  ViewController.swift
//  homespeak
//
//  Created by Eugene Yurtaev on 07/08/15.
//  Copyright (c) 2015 Deez Apps. All rights reserved.
//

import UIKit
import MediaPlayer
import CoreLocation
import MapKit
import SystemConfiguration


let g_licenseKey = "2FA8-2FD6-C27D-47E8-A256-D011-3751-2BD6"
var g_alert: UIAlertController!

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    let numberOfOptions: Int = 4
    let heightForOptionRow: CGFloat = 100

    @IBOutlet weak var optionsTableView: UITableView!
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        
        // testing music function
//        let mediaPickerController = MPMediaPickerController()
//        presentViewController(mediaPickerController, animated: true, completion: nil)
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("error")
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as! CLLocation
        locationManager.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        let location2 = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        if location.latitude != location2.latitude || location.longitude != location2.longitude{
            
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    
    
    
    
    
    
    
    
    
    
  
}

extension ViewController : UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfOptions
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Option Cell") as! OptionCell
        
        switch indexPath.row {
        case 0:
            cell.optionLabel.text = "Fitness report"
            cell.optionImageView.image = UIImage(named: "Health")
            break
        case 1:
            cell.optionLabel.text = "Stock report"
            cell.optionImageView.image = UIImage(named: "Stock")
            break
        case 2:
            cell.optionLabel.text = "Planner"
            cell.optionImageView.image = UIImage(named: "Calendar")
            break
        case 3:
            cell.optionLabel.text = "Auto-music"
            cell.optionImageView.image = UIImage(named: "Music")
            break
        default:
            break
        }
        
        return cell
        
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightForOptionRow
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            performSegueWithIdentifier("healthData", sender: self)
        }
        else if indexPath.row == 3{
            performSegueWithIdentifier("musicPlaylists", sender: self)

        }
    }
}
