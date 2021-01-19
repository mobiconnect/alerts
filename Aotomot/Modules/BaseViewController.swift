//
//  BaseViewController.swift
//  Aotomot
//
//  Created by AOTOMOT on 4/7/18.
//  Copyright © 2018 Aotomot. All rights reserved.
//

import UIKit
import ViewAnimator

class BaseViewController: UIViewController{
  
  private let animations = [AnimationType.from(direction: .bottom, offset: 60.0)]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.setNeedsStatusBarAppearanceUpdate()
    self.view.backgroundColor = UIColor(hex: "#F7F9F8")
  }

  
  func animateViews(_ subViews:[UIView]){
    UIView.animate(views: subViews, animations: self.animations, initialAlpha: 0.0, finalAlpha: 1.0)
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    get {
      return .lightContent
    }
  }
}

