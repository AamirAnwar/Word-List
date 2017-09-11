//
//  WDHelpers.swift
//  Wordist
//
//  Created by Aamir  on 10/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import Foundation
import UIKit

enum WDHelpers {
    static func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func blackout(view:UIView) -> WDBlackoutView? {
        guard let superView = view.superview else {
            return nil
        }
        
        let blackoutView = WDBlackoutView()
        blackoutView.frame = superView.frame
        blackoutView.cutoutRect = view.frame
        blackoutView.backgroundColor = UIColor.clear
        blackoutView.isOpaque = false
        superView.addSubview(blackoutView)
        blackoutView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            
            blackoutView.alpha = 1
        }
        
        
        
        return blackoutView
        
    }
    
}


extension String {
    func convertHtmlSymbols() throws -> String? {
        guard let data = data(using: .utf8) else { return nil }
        return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil).string
    }
}
