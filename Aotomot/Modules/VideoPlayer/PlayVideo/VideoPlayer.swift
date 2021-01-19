//
//  VideoPlayer.swift
//  360VideoPlayer
//
//  Created by Prianka Liz Kariat on 9/20/16.
//  Copyright © 2016 Prianka Liz Kariat. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class VideoPlayer : NSObject {
 
  private var videoUrl : URL!
  private var player: AVPlayer?
  private var qPlayer: AVQueuePlayer?
  private let playerItems = [AVPlayerItem]()
  private var currentTrack = 0

  convenience init?(videoFileName: String, videoFileType: String) {
    
    let url = Bundle.main.url(forResource: videoFileName, withExtension: videoFileType)
    
    if let url = url {
      self.init(url: url)
    }
    else {
      
      return nil
    }
  }
  
  init(url: URL) {
    
    videoUrl = url
    player?.isMuted = true
    super.init()
  }

    init(items: [URL]) {
        
        var playItems:[AVPlayerItem] = []
        for item in items{
            let playItem:AVPlayerItem = AVPlayerItem.init(url: item)
            playItems.append(playItem)
        }
        qPlayer = AVQueuePlayer.init(items: playItems)
        super.init()
    }

  func setUpPlayerInView(view: UIView) {
    
    guard videoUrl != nil && player == nil else {
      
      return
    }
    
    let avPlayerItem = AVPlayerItem(url: videoUrl)
    player = AVPlayer(playerItem: avPlayerItem)
    player?.isMuted = true
    let playerLayer = view.layer as! AVPlayerLayer
    playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    playerLayer.player = player
    
  }
  
    func playLoop(){
        self.player?.play()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                self.player?.seek(to: CMTime.zero)
                self.player?.play()
            }
        })
    }
    
  func play() {
    player?.play()
  }
  
  func pauseVideo() {
    
    if player?.rate != 0 {

      player?.pause()
    }
  }
  
    func previousTrack() {
        if currentTrack - 1 < 0 {
            currentTrack = (playerItems.count - 1) < 0 ? 0 : (playerItems.count - 1)
        } else {
            currentTrack -= 1
        }
        
        playTrack()
    }
    
    func nextTrack() {
        if currentTrack + 1 > playerItems.count {
            currentTrack = 0
        } else {
            currentTrack += 1;
        }
        
        playTrack()
    }
    
    func playTrack() {
        
        if playerItems.count > 0 {
            player?.replaceCurrentItem(with: playerItems[currentTrack])
            player?.play()
        }
    }
    
  func seekToTime(duration: Double, complationHandler: @escaping (Bool) -> Void) {
    
    if let currentItem = player?.currentItem {
      let time = CMTimeMakeWithSeconds(duration, preferredTimescale: currentItem.asset.duration.timescale)
      
      player?.seek(to: time, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { (complete) in
        
        DispatchQueue.main.async {
          
          complationHandler(complete)

        }
        
      })
    }
  }
  
  func durationOfVideo() -> Double {
    
    guard let currentItem = player?.currentItem else {

      return 0.0
    }
    
    return CMTimeGetSeconds(currentItem.asset.duration)
  }

}
