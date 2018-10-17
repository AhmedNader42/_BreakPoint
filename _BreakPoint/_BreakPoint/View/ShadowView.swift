//
//  ShadowView.swift
//  _BreakPoint
//
//  Created by ahmed on 9/10/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = .zero
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.awakeFromNib()
    }

}
