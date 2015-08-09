//
//  ViewController.swift
//  ExperimentMusic
//
//  Created by Adrian Wisaksana on 8/8/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import UIKit

import MediaPlayer

class PlaylistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // 1. playlists list
        let playlists = MPMediaQuery.playlistsQuery().collections
        
        if let playlist = playlists {

            for playlist in playlist {

                // get playlist name
                let playlistName: AnyObject! = playlist.valueForProperty(MPMediaPlaylistPropertyName)
                
                // TODO: Display playlist name in a table view
                println(playlistName)
                
            }
            
        } else {
            
            println("There is no playlist. Please create a playlist.")
            
        }

        
        // 2. choose playlist and set of songs
        var songsList: [AnyObject] = []
        
        // select playlist name
        var selectedPlaylistName = "N2012"
        
        for playlist in playlists {
            
            let playlistName: AnyObject! = playlist.valueForProperty(MPMediaPlaylistPropertyName)
            
            if (playlistName as! String == selectedPlaylistName) {
                let playlistItems = playlist.items()
                
                for song in playlistItems {
                    songsList.append(song)
                }
            }
            
        }
        
        // 3. play song
        if songsList.count != 0 {
            let songCollection = MPMediaItemCollection(items: songsList)
            
            let musicPlayer = MPMusicPlayerController.systemMusicPlayer()
            musicPlayer.setQueueWithItemCollection(songCollection)
            
            musicPlayer.play()
        }

  
        
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

