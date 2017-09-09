//
//  WDSearchResultTableViewCell.swift
//  Wordist
//
//  Created by Aamir  on 08/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import Foundation
import UIKit
class WDSearchResultTableViewCell:UITableViewCell {
    let titleLabel = UILabel()
    let bottomSeparator = WDSeparator.init(type: .WDSeparatorTypeMiddle, frame: .zero)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createViews()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
    }

    func createViews() {
        
        // Title
        titleLabel.font = WDFontTitleMedium
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Bottom separator
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomSeparator)
        
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: kSidePadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -kSidePadding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13)
            ])
        
        
        NSLayoutConstraint.activate([bottomSeparator.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                                     bottomSeparator.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                                     bottomSeparator.heightAnchor.constraint(equalToConstant: 1),
                                     bottomSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                                     ])
    }
    
    func setTitle(_ title:String) {
        titleLabel.text = title
    }
}
