//
//  WDSeparator.swift
//  Wordist
//
//  Created by Aamir  on 08/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit
enum WDSeparatorType {
    case WDSeparatorTypeMiddle
}
class WDSeparator: UIView {
    convenience init(type:WDSeparatorType, frame:CGRect) {
        self.init(frame: frame)
        switch type {
        case .WDSeparatorTypeMiddle:
            self.backgroundColor = WDSeparatorGray
        }
    }
}
