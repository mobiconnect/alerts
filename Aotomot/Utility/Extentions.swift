//
//  Extension.swift
//  Aotomot
//
//  Created by AOTOMOT on 4/7/18.
//  Copyright © 2018 Aotomot. All rights reserved.
//

import UIKit
import Foundation

extension String {
  var isValidURL: Bool {
    if let url = URL(string: self) {
      return UIApplication.shared.canOpenURL(url)
    }
    return false
  }
 
  func contains(find: String) -> Bool{
    return self.range(of: find) != nil
  }
}

extension TimeInterval{
  var toDate:Date{
    let digitCount = String(Int(self)).count
    if digitCount == 10{
      return Date(timeIntervalSince1970: self)
    }else{
      return Date(timeIntervalSince1970: self/1000)
    }
  }
}

extension Date{
  func localDateString(_ format:String="dd.MM.yyyy")->String{
    let formatter = DateFormatter();
    formatter.dateFormat = format
    var systemTimeZoneAbbreviation: String { return NSTimeZone.system.abbreviation(for: Date()) ?? ""}
    formatter.timeZone = TimeZone(abbreviation: systemTimeZoneAbbreviation)
    let defaultTimeZoneStr = formatter.string(from: self)
    return defaultTimeZoneStr
  }
}

extension UIView{
  func addShadow(radius:CGFloat = 1.0,color:UIColor = UIColor.black){
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.layer.shadowRadius = 2.0
    self.layer.shadowOpacity = 0.2
    self.layer.masksToBounds = false
    self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [UIRectCorner.topLeft , UIRectCorner.bottomLeft,UIRectCorner.bottomRight,UIRectCorner.topRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
  }
}

extension UIColor {
  
  convenience init(hex: String,alpha:CGFloat = 1.0) {
    var red:   CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue:  CGFloat = 0.0
    var alpha: CGFloat = alpha
    var hex:   String = hex
    
    if hex.hasPrefix("#") {
      let index = hex.index(hex.startIndex, offsetBy: 1)
      hex = String(hex[index...])
    }
    
    let scanner = Scanner(string: hex)
    var hexValue: CUnsignedLongLong = 0
    if scanner.scanHexInt64(&hexValue) {
      switch (hex.count) {
      case 3:
        red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
        green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
        blue  = CGFloat(hexValue & 0x00F)              / 15.0
      case 4:
        red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
        green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
        blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
        alpha = CGFloat(hexValue & 0x000F)             / 15.0
      case 6:
        red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
        green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
        blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
      case 8:
        red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
        green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
        blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
        alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
      default:
        print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
      }
    } else {
      print("Scan hex error")
    }
    self.init(red:red, green:green, blue:blue, alpha:alpha)
  }
  
  /**
   Hex string of a UIColor instance.
   
   - parameter rgba: Whether the alpha should be included.
   */
  public func hexString(_ includeAlpha: Bool = false) -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    
    if (includeAlpha) {
      return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
    } else {
      return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
  }
  
  open override var description: String {
    return self.hexString(true)
  }
  
  open override var debugDescription: String {
    return self.hexString(true)
  }
}


extension UIWindow {
  
  func switchRootViewController(_ viewController: UIViewController,  animated: Bool = true, duration: TimeInterval = 0.3, options: UIView.AnimationOptions = .transitionFlipFromRight, completion: (() -> Void)? = nil) {
    guard animated else {
      rootViewController = viewController
      return
    }
    
    UIView.transition(with: self, duration: duration, options: options, animations: {
      let oldState = UIView.areAnimationsEnabled
      UIView.setAnimationsEnabled(false)
      self.rootViewController = viewController
      UIView.setAnimationsEnabled(oldState)
    }) { _ in
      completion?()
    }
  }
}



extension UIApplication {
  class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let presented = controller?.presentedViewController {
      return topViewController(controller: presented)
    }
    if let navigationController = controller as? UINavigationController {
      return topViewController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
      if let selected = tabController.selectedViewController {
        return topViewController(controller: selected)
      }
    }
    return controller
  }
}
