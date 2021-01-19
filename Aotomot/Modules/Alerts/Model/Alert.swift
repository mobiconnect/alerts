//
//  Alert.swift
//  DriverManagement
//
//  Created by Mobiddiction on 3/9/18.
//  Copyright © 2018 mobiddiction. All rights reserved.
//

import Foundation

struct Alert {
  var id:Int = -1
  var title:String = ""
  var description:String = ""
  var thumbnailURL:URL?
  var videoURL:URL?
  var callToAction:URL?
  var dateCreated:Date?
  var isRead:Bool = false
  var push:Bool = false
  var status:String = ""
  var ref:AlertRef?
  
  init(_ alertsInfo:[String : Any]) {
    self.title = alertsInfo["notifTitle"] as? String ?? ""
    self.status = alertsInfo["status"] as? String ?? ""
    self.description = alertsInfo["notifText"] as? String ?? ""
    if let lvideoUrl = alertsInfo["notifSound"] as? String {
      if lvideoUrl.isValidURL{
        self.videoURL = URL(string: lvideoUrl)
      }
    }

    if let image = alertsInfo["image"] as? [String : AnyObject]{
      if let url = image["url"] as? String{
        if url.isValidURL{
          self.thumbnailURL = URL(string: url)
        }
      }
    }

    if let id = alertsInfo["id"] as? Int {
      self.id = id
    }
    if let lcreatedDate = alertsInfo["createdDate"] as? TimeInterval{
      self.dateCreated = lcreatedDate.toDate
    }
    
    if let isRead = alertsInfo["isRead"] as? Bool{
      self.isRead = isRead
    }
    if let push = alertsInfo["push"] as? Bool{
      self.push = push
    }
    if let ref = alertsInfo["ref"] as? [String:Any]{
      self.ref = AlertRef.init(ref)
    }
    
    if let lcallToAction = alertsInfo["callToAction"] as? String {
      if lcallToAction.isValidURL{
        self.callToAction = URL(string: lcallToAction)
      }
    }
  }
  
  mutating func update(alertsInfo:[String : AnyObject]){
    self.title = alertsInfo["notifTitle"] as? String ?? ""
    self.status = alertsInfo["status"] as? String ?? ""
    self.description = alertsInfo["notifText"] as? String ?? ""
    if let lvideoUrl = alertsInfo["notifSound"] as? String {
      if lvideoUrl.isValidURL{
        self.videoURL = URL(string: lvideoUrl)
      }
    }
    if let image = alertsInfo["image"] as? [String : AnyObject]{
      if let url = image["url"] as? String{
        if url.isValidURL{
          self.thumbnailURL = URL(string: url)
        }
      }
    }
    if let isRead = alertsInfo["isRead"] as? Bool{
      self.isRead = isRead
    }
    if let push = alertsInfo["push"] as? Bool{
      self.push = push
    }
    if let ref = alertsInfo["ref"] as? [String:Any]{
      self.ref = AlertRef.init(ref)
    }
    if let lcallToAction = alertsInfo["callToAction"] as? String {
      if lcallToAction.isValidURL{
        self.callToAction = URL(string: lcallToAction)
      }
    }
  }
}

struct AlertRef {
  var id:Int?
  var name:String?
  
  init(_ ref:[String:Any]) {
    if let id = ref["id"] as? Int {
      self.id = id
    }
    if let lname = ref["name"] as? String {
      self.name = lname
    }
  }
}
