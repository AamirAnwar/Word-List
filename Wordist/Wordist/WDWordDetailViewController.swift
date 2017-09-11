//
//  WDWordDetailViewController.swift
//  Wordist
//
//  Created by Aamir  on 10/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit
let DefinitionHeadingString = "Definition"

protocol WDWordDetailViewControllerDelegate {
    func didSaveWord(wordInstance:WordObject)
    func didRemoveWord(wordInstance:WordObject)
}

class WDWordDetailViewController: UIViewController {
    
    let wordLabel = UILabel()
    let definitionHeadingLabel = UILabel()
    let definitionLabel = UILabel()
    fileprivate var wordObject:WordObject!
    var shouldShowAddButton = false
    let headerView = WDNavigationHeader()
    let wordLabelSeparator = WDSeparator.init(type: .WDSeparatorTypeMiddle, frame: .zero)
    let definitionLabelSeparator = WDSeparator.init(type: .WDSeparatorTypeMiddle, frame: .zero)
    let bottomRectButton = WDRoundRectButton()
    var delegate:WDWordDetailViewControllerDelegate?
        
    convenience init(withWord word:WordObject) {
        self.init()
        self.wordObject = word
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // Navigation header view
        headerView.setBackButton(title: "")
        if let backTitle = self.navigationController?.navigationBar.items?.last?.title {
            headerView.setBackButton(title: backTitle)
        }
        
        headerView.delegate = self
        view.addSubview(headerView)
        
        
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
        bottomRectButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        wordLabel.font = WDFontBigTitleSemiBold
        wordLabel.textColor = WDTextBlack
        
        definitionHeadingLabel.font = WDFontSectionHeader
        definitionHeadingLabel.textColor = WDLightGray
        
        definitionLabel.font = WDFontBodyText
        definitionLabel.textColor = WDTextBlack
        
        refreshBottomButton()
        bottomRectButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
        
        view.addSubview(wordLabel)
        view.addSubview(wordLabelSeparator)
        view.addSubview(definitionHeadingLabel)
        view.addSubview(definitionLabel)
        view.addSubview(definitionLabelSeparator)
        view.addSubview(bottomRectButton)
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
        
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        var bottomPadding = kDefaultPadding
        if let tabBarHeight = tabBarHeight {
            bottomPadding += tabBarHeight
        }
        
        NSLayoutConstraint.activate([
            bottomRectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kSidePadding),
            bottomRectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -kSidePadding),
            bottomRectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(bottomPadding) )
            ])
        
        bottomRectButton.isHidden = !shouldShowAddButton
        
    }
    
    func refreshBottomButton() {
        if WDWordListManager.sharedInstance.isWordSaved(word: self.wordObject).exists == true {
            bottomRectButton.setTitle("Added", for: .normal)
            bottomRectButton.roundRectButtonState = .WDRoundRectButtonStateGreen
        }
        else {
            bottomRectButton.setTitle("Add", for: .normal)
        }
    }
    
    @objc func bottomButtonTapped() {
        switch bottomRectButton.roundRectButtonState {
        case .WDRoundRectButtonStateDefault:
            WDWordListManager.sharedInstance.save(word: self.wordObject)
            bottomRectButton.roundRectButtonState = .WDRoundRectButtonStateGreen
            delegate?.didSaveWord(wordInstance: self.wordObject)
            
            
        case .WDRoundRectButtonStateGreen:
            WDWordListManager.sharedInstance.remove(word: self.wordObject)
            bottomRectButton.roundRectButtonState = .WDRoundRectButtonStateDefault
            delegate?.didRemoveWord(wordInstance: self.wordObject)
        }
        refreshBottomButton()
    }
}

extension WDWordDetailViewController:WDNavigationHeaderDelegate {
    func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
