//
//  PlayViewController.swift
//  homespeak
//
//  Created by Eugene Yurtaev on 08/08/15.
//  Copyright (c) 2015 Deez Apps. All rights reserved.
//

import UIKit


class PlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
   if !HKWControlHandler.sharedInstance().initializing() && !HKWControlHandler.sharedInstance().isInitialized()
   {
            println("initializing in PlaylistTVC")
            
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }

    @IBAction func buttonTapped(sender: AnyObject) {
        var audioPlayer:AVAudioPlayer!
        
        var audioFilePath = NSBundle.mainBundle().pathForResource("song", ofType: "mp3")
        
        if audioFilePath != nil {
            
            var audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
            
            HKWControlHandler.sharedInstance().printDeviceList()
            HKWControlHandler.sharedInstance().playCAF(audioFileUrl, songName: "Song", resumeFlag: true)
        } else {
            println("audio file is not found")
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
