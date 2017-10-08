//
//  WDSearchTag.swift
//  Wordist
//
//  Created by Aamir  on 07/10/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import Foundation
import UIKit

enum WDSearchTag:String {
    case Added
    
    static func getBackgroundColorFor(tag:WDSearchTag) -> UIColor {
        switch tag {
        case .Added:
            return WDColorGreen
        }
    }
}
