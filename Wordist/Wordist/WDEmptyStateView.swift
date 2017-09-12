//
//  WDEmptyStateView.swift
//  Wordist
//
//  Created by Aamir  on 11/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit

class WDEmptyStateView: UIView {

    let iconLabel = UILabel()
    let messageLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createEmptyState()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createEmptyState()
    }
    
    func createEmptyState() {
        self.backgroundColor = UIColor.white
        iconLabel.textColor = WDMainTheme
        iconLabel.font = WDIconFontEmptyState
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.textAlignment = .center
        if let iconString = try? "&#xf4d7;".convertHtmlSymbols() {
            iconLabel.text = iconString
        }
        self.addSubview(self.iconLabel)
        
        messageLabel.textColor = WDTextBlack
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textAlignment = .center
        messageLabel.font = WDFontBodyText
        messageLabel.numberOfLines = 0
        messageLabel.text = "You don't seem to have any words saved.\n Words you add will show up here!"
        self.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            iconLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -kDefaultPadding)
            ])
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: iconLabel.centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 2*kDefaultPadding),
            
            ])
        
        
        
    }
}
