//
//  APIData.swift
//  Aotomot
//
//  Created by AOTOMOT on 4/7/18.
//  Copyright © 2018 Aotomot. All rights reserved.
//

import UIKit
import Alamofire

class APIData: NSObject {
  
  let userdefaults=UserDefaults.standard

  class var shared: APIData {
    struct Singleton {
      static let instance = APIData()
    }
    return Singleton.instance
  }
  
  private func appInstenceID()->String{
    if let token=userdefaults.value(forKey: "app_uuid"){
      return token as? String ?? ""
    }else{
      let uuid = UUID().uuidString
      userdefaults.setValue(uuid, forKey: "app_uuid")
      return uuid
    }
  }
  
  func deviceToken(_ token:String){
    userdefaults.setValue(token, forKey: "user_device_token")
  }
  
  private func deviceToken()->String?{
    if let token=userdefaults.value(forKey: "user_device_token"){
      return token as? String
    }else{
      return nil
    }
  }
  
  private func deviceId(_ deviceId:Int?){
    userdefaults.setValue(deviceId, forKey:"device_id")
  }
  
  private func deviceId()->Int?{
    if let deviceId=userdefaults.value(forKey: "device_id"){
      return deviceId as? Int
    }else{
      return nil
    }
  }
  
  /// network error
  struct MBDError : Error
  {
    public var code:Int
    public var message:String
    public var apiMessage:String
    
    public init(code: Int?,apiMessage:Any?)
    {
      self.code = code ?? 500
      switch code {
      case 400:
        self.message = "We are unable to process your request at this time."
      case 401:
        self.message = "Seems you don't have the right access."
      case 403:
        self.message = "Seems you don't have the right access."
      case 404:
        self.message = "We can't seem to find that."
      default:
        self.message = "Seems there's a problem, please try again in a while."
      }
      if apiMessage != nil,let response = apiMessage as? [String:Any], let message = response["message"] as? String{
        self.apiMessage = message
      }else{
        self.apiMessage = self.message
      }
    }
  }
  
  func getAlerts(_ success:@escaping ([Alert]) -> Void){
      if !Reachability.isConnectedToNetwork(){
        return
      }
      
      let headers = [
        "accept":"application/json",
      ]
      Alamofire.request(Urls.alerts,method: .get, parameters: nil, encoding: URLEncoding.default,headers: headers)
        .responseJSON { response in
          print("\n**************************\nresponse code:\(response.response?.statusCode ?? 500)\nresponse:\((response.result.value ?? "No result value"))\n**************************\n")
          if response.result.isSuccess{
            if response.response?.statusCode == 200{
              var alertItems:[Alert] = []
              if let alerts = response.result.value as? [[String:Any]] {
                for alert in alerts{
                  let alertInfo = Alert(alert)
                  alertItems.append(alertInfo)
                }
                alertItems.sort(by: { $0.dateCreated?.compare($1.dateCreated!) == .orderedDescending })
                success(alertItems)
              }else{
                let error = MBDError(code: response.response?.statusCode, apiMessage: response.result.value)
                Utility.showAlert(message: error.message)
              }
            }else{
              let error = MBDError(code: response.response?.statusCode, apiMessage: response.result.value)
              Utility.showAlert(message: error.message)
            }
          }else{
            let error = MBDError(code: response.response?.statusCode, apiMessage: response.result.value)
            Utility.showAlert(message: error.message)
          }
      }
    }
  
  func postDeviceRegister(_ success: @escaping (Bool) -> Void){
    
    let headers = [
      "Content-Type":"application/json",
      "accept":"application/json",
    ]
    let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
    let build = Bundle.main.infoDictionary!["CFBundleVersion"]!
    let post_parameters:NSMutableDictionary=[
      "udid":appInstenceID(),
      "deviceType":"\(UIDevice.current.model.uppercased())",
      "deviceName":"\(UIDevice.current.name)",
      "deviceOS":"\(UIDevice.current.systemVersion)",
      "awsEndpoint":Urls.baseUrl,
      "appVersion":"\(version)(\(build)"
    ]
    if deviceToken() != nil {
      post_parameters.setValue(deviceToken(), forKey: "deviceToken")
      post_parameters.setValue(true, forKey: "pushNotifications")
    }
    
    var parameters = [String : Any]()
    for (key, value) in post_parameters {
      parameters[key as! String] = value
    }
    
    if let id = deviceId(){
      let updateDeviceUrl = "\(Urls.baseUrl)device/update/\(id)?\(Urls.apiKey)"
      Alamofire.request(updateDeviceUrl,method: .put, parameters: nil, encoding: URLEncoding.default,headers: headers)
        .responseJSON { response in
          if (response.result.isSuccess
          && response.response?.statusCode == 200),
            let data = response.result.value as? [String:Any],
            let id = data["id"] as? Int{
            self.deviceId(id)
            success(true)
          }else{
            
          }
      }
    }else{
      Alamofire.request(Urls.addDevice,method: .post, parameters: nil, encoding: URLEncoding.default,headers: headers)
        .responseJSON { response in
          if (response.result.isSuccess
            && response.response?.statusCode == 200),
            let data = response.result.value as? [String:Any],
            let id = data["id"] as? Int{
            self.deviceId(id)
            success(true)
          }else{
            
          }
      }
    }
  }
}


