
//
//  AlertsListCell.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 13/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit
import SDWebImage

class AlertsListCell: UITableViewCell {
  
  @IBOutlet weak var imgLogo: UIImageView!
  @IBOutlet weak var lbTitle: UILabel!
  @IBOutlet weak var lbDescription: UILabel!
  @IBOutlet weak var lbDate: UILabel!
  @IBOutlet weak var labelLeftConstraint: NSLayoutConstraint!
  @IBOutlet weak var iconCalendar: UIImageView!
  @IBOutlet weak var btnCallToAction: UIButton!
  @IBOutlet weak var btnTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var btnPlayVideo: UIButton!
  var alert:Alert?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.imgLogo.layer.cornerRadius = 4.0
    self.btnCallToAction.backgroundColor = UIColor(hex: "#E31349")
    self.btnCallToAction.setTitleColor( UIColor(hex: "#444444"), for: .normal)
  }
  
  func updateData(_ alertInfo: Alert) {
    self.alert = alertInfo
    self.lbTitle.text = alertInfo.title
    self.lbDescription.text = alertInfo.description
    self.iconCalendar.isHidden = true
    self.lbDate.text = ""
    if let date = alertInfo.dateCreated{
      let formatter = DateFormatter()
      formatter.dateFormat = "hh:mm a"
      let time = formatter.string(from: date)
      self.lbDate.text = time
      self.lbDate.text = date.localDateString()
      self.iconCalendar.isHidden = false
    }

    self.labelLeftConstraint.constant = 15.0
    self.imgLogo.backgroundColor = UIColor.clear
    self.imgLogo.image = nil
    
    self.imgLogo.isHidden = true
    self.btnPlayVideo.isHidden = true
    if alertInfo.thumbnailURL != nil{
      self.imgLogo.isHidden = false
      self.labelLeftConstraint.constant = 85.0
      self.imgLogo.sd_setImage(with: alertInfo.thumbnailURL, placeholderImage:nil, options: .avoidAutoSetImage, completed: { (image, _, type, _) -> Void in
        if (image != nil) {
          if (type == SDImageCacheType.none || type == SDImageCacheType.disk) {
            UIView.transition(with: self.imgLogo, duration: 0.75, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
              self.imgLogo.image = image
              self.imgLogo.backgroundColor = UIColor.clear
            }, completion: nil)
          } else {
            self.imgLogo.image = image
            self.imgLogo.backgroundColor = UIColor.clear
          }
        }
      })
    }else{
      self.imgLogo.backgroundColor = UIColor(hex: "#E31349")
    }
    
    if alertInfo.videoURL != nil{
      self.labelLeftConstraint.constant = 85.0
      self.imgLogo.isHidden = false
      self.btnPlayVideo.isHidden = false
    }
    
    if alertInfo.callToAction != nil{
      btnCallToAction.isHidden = false
      btnTopConstraint.constant = 15.0
    }else{
      btnCallToAction.isHidden = true
      btnTopConstraint.constant = 0.0
    }
  }
  
  @IBAction func callToAction(_ sender: Any) {
    if let url = alert!.callToAction{
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
  
  @IBAction func playVideo(_ sender: Any) {
    if let videoURL = alert?.videoURL{
      if let topVC = UIApplication.topViewController(){
        if videoURL.absoluteString.contains(find: "youtube"){
          if let youtubeVC = UIStoryboard(name: "VideoPlayer", bundle: Bundle.main).instantiateViewController(withIdentifier: "YoutubePlayerViewController") as? YoutubePlayerViewController{
            youtubeVC.videoUrl = videoURL
            topVC.present(youtubeVC, animated: true, completion: nil)
          }
        }else{
          if let videoVC = UIStoryboard(name: "VideoPlayer", bundle: Bundle.main).instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController{
            videoVC.videoUrl = videoURL
            topVC.present(videoVC, animated: true, completion: nil)
          }
        }
      }
    }
  }
}


