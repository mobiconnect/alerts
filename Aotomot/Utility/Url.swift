//
//  Url.swift
//  Aotomot
//
//  Created by AOTOMOT on 4/7/18.
//  Copyright © 2018 Aotomot. All rights reserved.
//

import Foundation

struct Urls{

  static let workspaceName = ""
  static let apiKey = ""
  static let baseUrl = "https://\(workspaceName).aotomot.com/api/"
  
  // news
  static let alerts:String = "\(baseUrl)news/findAll?apiKey=\(apiKey)"
  static let addDevice:String = "\(baseUrl)device/add?\(apiKey)"

}
