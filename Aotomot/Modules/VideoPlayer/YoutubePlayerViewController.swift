//
//  YoutubePlayerViewController.swift
//  Aotomot
//
//  Created by Mobiddiction on 30/10/18.
//  Copyright © 2018 mobiddiction. All rights reserved.
//

import UIKit

class YoutubePlayerViewController: UIViewController {
  
  @IBOutlet weak var videoView: YouTubePlayerView!
  var videoUrl:URL?
  private var validUrl:Bool = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    videoView.delegate = self
    videoView.playerVars = ["playsinline": 1 as AnyObject, "autoplay": 1 as AnyObject, "autohide": 1 as AnyObject, "controls" : 0 as AnyObject, "showinfo" : 0 as AnyObject, "modestbranding" : 1 as AnyObject, "rel" : 0 as AnyObject]
    if videoUrl != nil{
      validUrl = videoView.loadVideoURL(videoUrl!)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if !validUrl{
      Utility.showAlert("Invalid url", message: "Video could not be loaded. Try again later.", okAction: {
        self.dismiss(animated: true, completion: nil)
      })
    }
  }
  
  @IBAction func close(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
}

extension YoutubePlayerViewController:YouTubePlayerDelegate{
  
  func playerReady(_ videoPlayer: YouTubePlayerView) {
    videoView.play()
  }
}
