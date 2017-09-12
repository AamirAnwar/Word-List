//
//  WDBlackoutView.swift
//  Wordist
//
//  Created by Aamir  on 11/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit

class WDBlackoutView: UIView {
    var cutoutRect:CGRect?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let blackoutColor = WDTextBlack.withAlphaComponent(0.9)
        blackoutColor.setFill()
        if let cutoutRect = cutoutRect {
            UIRectFill(rect)
            let rectIntersection = rect.intersection(cutoutRect)
            
            let clearColor = UIColor.clear
            clearColor.setFill()
            UIRectFill(rectIntersection)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
 

}
