//
//  ContentEmptyFooter.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 12/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit
import SDWebImage

class ContentEmptyFooter: UITableViewHeaderFooterView {

    @IBOutlet weak var viewIcon: UIView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
//        // Initialization code
        self.lbDescription.font = UIFont(name: "SourceSansPro-Regular", size: 20.0)!
        self.lbDescription.textColor = UIColor(hex: "#444444")
        self.bgView.backgroundColor = UIColor(hex: "#F7F9F8")
        self.viewIcon.backgroundColor = UIColor(hex: "#F7F9F8")
      self.viewIcon.layer.cornerRadius = self.viewIcon.frame.size.height/2
    }

    func updateView(_ text: String) {
        self.lbDescription.text = text
    }
    
    func styleView(_ color:UIColor,image:UIImage?){
        self.viewIcon.backgroundColor = color
        self.icon.image = image
    }
}
