//
//  Utility.swift
//  Aotomot
//
//  Created by AOTOMOT on 4/7/18.
//  Copyright © 2018 Aotomot. All rights reserved.
//

import UIKit
import SystemConfiguration

class Utility {

    class func convertStrToDescAttriuteStr(_ text:String)->NSAttributedString{
            let format = "<style>body{font-family:'SourceSansPro-Regular'; font-size:18px; color:#444444;} h3{font-family:'SourceSansPro-Semibold'; font-size:18px; color:#444444;} h2{font-family:'SourceSansPro-Semibold'; font-size:16px; color:#444444;} strong{font-family:'SourceSansPro-Semibold'; font-size:13px; color:#444444;} em{font-family:'SourceSansPro-Light'}</style>"
        let str = text + format

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(4.0)
        paragraphStyle.alignment=NSTextAlignment.left
        var attrStr = NSMutableAttributedString()
        do {
            attrStr = try NSMutableAttributedString(
                data: str.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0,length: attrStr.length))
        } catch {
            print(error)
        }
        return attrStr
    }


  class func showAlert(_ title: String="", message: String,buttonTitle: String="Ok".capitalized, okAction:@escaping () -> Void = {
        }) {
        if let controller = UIApplication.topViewController(){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.view.tintColor = UIColor(hex: "#E31349")
            alert.view.layer.cornerRadius = 4.0
            alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: {(_:UIAlertAction!) in
                okAction()
            }))
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                controller.present(alert, animated: true, completion: nil)
            }
        }
    }
}
