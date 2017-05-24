//
//  FancyView.swift
//  devslopes-social
//
//  Created by Dileep Gadiraju on 5/17/17.
//  Copyright © 2017 Dileep Gadiraju. All rights reserved.
//

import UIKit

class FancyView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
      //layer.shadowColor = CGColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }

}
