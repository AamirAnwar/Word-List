//
//  WDWordDetailViewController.swift
//  Wordist
//
//  Created by Aamir  on 10/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit
let DefinitionHeadingString = "Definition"

class WDWordDetailViewController: UIViewController {
    
    let wordLabel = UILabel()
    let definitionHeadingLabel = UILabel()
    let definitionLabel = UILabel()
    fileprivate var wordObject:WordObject!
    let headerView = WDNavigationHeader()
    
    let wordLabelSeparator = WDSeparator.init(type: .WDSeparatorTypeMiddle, frame: .zero)
    let definitionLabelSeparator = WDSeparator.init(type: .WDSeparatorTypeMiddle, frame: .zero)
    
    convenience init(withWord word:WordObject) {
        self.init()
        self.wordObject = word
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // Navigation header view
        headerView.setBackButton(title: "Search")
        headerView.delegate = self
        view.addSubview(headerView)
        
        view.backgroundColor = UIColor.white
        
        wordLabel.text = self.wordObject.word
        definitionLabel.text = self.wordObject.definition
        definitionHeadingLabel.text = DefinitionHeadingString
        
        wordLabel.numberOfLines = 0
        definitionLabel.numberOfLines = 0
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabelSeparator.translatesAutoresizingMaskIntoConstraints = false
        definitionHeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        definitionLabel.translatesAutoresizingMaskIntoConstraints = false
        definitionLabelSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        
        wordLabel.font = WDFontSearchTitleDemiBold
        wordLabel.textColor = WDTextBlack
        
        definitionHeadingLabel.font = WDFontSectionHeader
        definitionHeadingLabel.textColor = WDLightGray
        
        definitionLabel.font = WDFontBodyText
        definitionLabel.textColor = WDTextBlack
        
        view.addSubview(wordLabel)
        view.addSubview(wordLabelSeparator)
        view.addSubview(definitionHeadingLabel)
        view.addSubview(definitionLabel)
        view.addSubview(definitionLabelSeparator)
        
        // Constraints
        
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant:kStatusBarHeight),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: kNavigationBarHeight)
            ])
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 37),
            wordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            wordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -kSidePadding),
            
            wordLabelSeparator.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 2),
            wordLabelSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kSidePadding),
            wordLabelSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            wordLabelSeparator.heightAnchor.constraint(equalToConstant: kSeparatorHeight)
            
            ])
        
        NSLayoutConstraint.activate([
            definitionHeadingLabel.topAnchor.constraint(equalTo: wordLabelSeparator.bottomAnchor, constant: 30),
            definitionHeadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kSidePadding),
            definitionHeadingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -kSidePadding)
            ])
        
        
        NSLayoutConstraint.activate([
            definitionLabel.topAnchor.constraint(equalTo: definitionHeadingLabel.bottomAnchor, constant: kDefaultPadding),
            definitionLabel.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: wordLabel.trailingAnchor),
            
            
            definitionLabelSeparator.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 5),
            definitionLabelSeparator.leadingAnchor.constraint(equalTo: wordLabelSeparator.leadingAnchor),
            definitionLabelSeparator.trailingAnchor.constraint(equalTo: definitionLabel.trailingAnchor),
            definitionLabelSeparator.heightAnchor.constraint(equalToConstant: kSeparatorHeight)
            ])
    }

    
}

extension WDWordDetailViewController:WDNavigationHeaderDelegate {
    func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
