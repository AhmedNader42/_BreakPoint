
//
//  GradientView.swift
//  _BreakPoint
//
//  Created by ahmed on 9/16/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    var topColor:UIColor = #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    var bottomColor:UIColor = #colorLiteral(red: 0.2734826207, green: 0.1576239169, blue: 0.431805253, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}
