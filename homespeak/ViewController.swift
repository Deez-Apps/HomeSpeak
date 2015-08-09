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

let g_licenseKey = "2FA8-2FD6-C27D-47E8-A256-D011-3751-2BD6"
var g_alert: UIAlertController!

class ViewController: UIViewController {
    
  
    
    @IBAction func pause(sender: AnyObject) {
        HKWControlHandler.sharedInstance().pause()
    }
    
    var locationManager = CLLocationManager()
    let numberOfOptions: Int = 4
    let heightForOptionRow: CGFloat = 100
    
    var lastUserLocation: CLLocation?
    var userLocation : CLLocation?
    var timer: NSTimer?

    var isPlaying = false
    
    @IBOutlet weak var optionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        
        
        HKWDeviceEventHandlerSingleton.sharedInstance().delegate = self

        // testing music function
//        let mediaPickerController = MPMediaPickerController()
//        presentViewController(mediaPickerController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func viewWillAppear(animated: Bool) {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

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
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        if indexPath.row == 0{
            performSegueWithIdentifier("healthData", sender: self)
        }
        if indexPath.row == 3{
            performSegueWithIdentifier("musicPlaylists", sender: self)
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("error")
    }

    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        if let timer = timer {
            
        } else {
            userLocation = newLocation
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "changeLocation", userInfo: nil, repeats: true)
        }
        
    }
    
    func changeLocation() {
        var location2d = CLLocationCoordinate2D()
        if let lastUserLocation = lastUserLocation {
            location2d = CLLocationCoordinate2D(latitude: lastUserLocation.coordinate.latitude, longitude: lastUserLocation.coordinate.longitude)
        }
        let newLocation2d = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        if lastUserLocation == nil || location2d.latitude != newLocation2d.latitude || location2d.longitude != newLocation2d.longitude{
            println("location changed")
            
            if !HKWControlHandler.sharedInstance().initializing() && !HKWControlHandler.sharedInstance().isInitialized() {
                println("about to init speakers")
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    if HKWControlHandler.sharedInstance().initializeHKWirelessController(g_licenseKey, withSpeakersAdded: true) != 0 {
                        println("initializeHKWirelessControl failed : invalid license key")
                        return
                    }
                    println("initializeHKWirelessControl - OK");
                    
                    // dismiss the network initialization dialog
                    if g_alert != nil {
                        g_alert.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                })
            }
        }
        lastUserLocation = userLocation
        userLocation = nil
        timer?.invalidate()
        timer = nil
    }

}

extension ViewController : HKWDeviceEventHandlerDelegate {
    func hkwDeviceStateUpdated(deviceId: Int64, withReason reason: Int) {
        if reason < 5 {
            return
        }
        if !isPlaying {
            var audioPlayer:AVAudioPlayer!
            
            var audioFilePath = NSBundle.mainBundle().pathForResource("song", ofType: "mp3")
            
            if audioFilePath != nil {
                
                    var audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
                
//                var audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
                
//                HKWControlHandler.sharedInstance().printDeviceList()
                
//                let urlWithText = NSURL(string: "http://tts-api.com/tts.mp3?q=hello+world+plus+plus.")
                HKWControlHandler.sharedInstance().playCAF(audioFileUrl, songName: "song", resumeFlag: true)
//                HKWControlHandler.sharedInstance().playStreamingMedia("http://tts-api.com/tts.mp3?q=hello+world+plus+plus+plus+plus", withCallback: { (result) -> Void in
//                    println("completed")
//                    self.isPlaying = false
//                })
                isPlaying = true
            } else {
                println("audio file is not found")
            }
        }
    }
    
    func hkwErrorOccurred(errorCode: Int, withErrorMessage errorMesg: String!) {
        println(errorMesg)
    }
}
