//
//  AppDelegate.swift
//  Aotomot
//
//  Created by AOTOMOT on 4/7/18.
//  Copyright © 2018 Aotomot. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  class func shared() -> AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate;
  }
  
  func changeRootViewControllerWithIdentifier(identifier:String!, storyBoard:String!,animate:Bool=false,options: UIView.AnimationOptions = .transitionCrossDissolve) {
    let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
    let desiredViewController = storyboard.instantiateViewController(withIdentifier: identifier);
    setupNotificationSetting()
    self.window?.switchRootViewController(desiredViewController,animated: animate,options:options)
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // Global settings
    return true
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    var token = ""
    for i in 0..<deviceToken.count {
      token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
    }
    print("Device token is \(token)")
    APIData.shared.deviceToken(token)
  }

  
  // MARK: - Notification
  func setupNotificationSetting(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
      (granted, error) in
      print("Permission granted: \(granted)")
      
      guard granted else { return }
      self.getNotificationSettings()
    }
  }
  
  func getNotificationSettings() {
    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
      print("Notification settings: \(settings)")
      guard settings.authorizationStatus == .authorized else { return }
      DispatchQueue.main.async(execute: {
        UIApplication.shared.registerForRemoteNotifications()
      })
    }
  }
}


