//
//  VideoPlayerViewController.swift
//  Aotomot
//
//  Created by Mobiddiction on 30/10/18.
//  Copyright © 2018 mobiddiction. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerViewController: AVPlayerViewController {
  var videoUrl:URL?

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if videoUrl != nil{
      self.player = AVPlayer(url: videoUrl!)
    }
  }

}
