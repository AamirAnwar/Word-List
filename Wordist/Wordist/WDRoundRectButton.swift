//
//  WDRoundRectButton.swift
//  Wordist
//
//  Created by Aamir  on 10/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit

class WDRoundRectButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefaultProperties()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaultProperties()
    }
    
    convenience init() {
        self.init(type: .system)
        setDefaultProperties()
    }
    
    func setDefaultProperties() {
        self.backgroundColor = WDMainTheme
        self.titleLabel?.font = WDFontBigButtonTitle
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = kCornerRadius
    }
}
