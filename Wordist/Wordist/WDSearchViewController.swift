//
//  WDSearchViewController.swift
//  Wordist
//
//  Created by Aamir  on 07/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit

let kTextFieldHeight:CGFloat = 55
let kSearchResultReuseIdentifer = "kSearchResultCell"
let kDottedLoaderWidth:CGFloat = 52
let kDottedLoaderHeight:CGFloat = 16

class WDSearchViewController: UIViewController {
    let searchTextField = UITextField()
    let textFieldSeparator = WDSeparator.init(type: .WDSeparatorTypeMiddle, frame: .zero)
    let searchTableView = UITableView.init(frame: .zero, style: .plain)
    let wordSearchObject = WordSearch()
    let dottedLoader = WDDottedLoader(frame: CGRect(x: 0, y: 0, width: kDottedLoaderWidth, height: kDottedLoaderHeight))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForNotifications()
        createSearchTextField()
        createTableView()
        createDottedLoader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if searchTextField.text?.isEmpty == false {
           searchTextField.becomeFirstResponder()
        }
    }
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(willShowKeyboard(notification:)) , name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(willHideKeyboard) , name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    fileprivate func createTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.tableFooterView = UIView.init()
        searchTableView.rowHeight = UITableViewAutomaticDimension
        searchTableView.estimatedRowHeight = 55
        searchTableView.register(WDSearchResultTableViewCell.self, forCellReuseIdentifier: kSearchResultReuseIdentifer)
        searchTableView.separatorStyle = .none
        view.addSubview(searchTableView)
    }
    
    
    fileprivate func createSearchTextField() {
        searchTextField.frame = CGRect(x: kSidePadding, y: (view.frame.size.height - kTextFieldHeight)/2 - 20, width: view.frame.size.width - 2*kSidePadding, height: kTextFieldHeight)
        searchTextField.tintColor = WDTextBlack
        let placeholderAttributes = [NSAttributedStringKey.font: WDFontSearchPlaceholderBig as Any,
                                     NSAttributedStringKey.foregroundColor: WDLightGray as Any]
        searchTextField.font = WDFontBigTitleSemiBold
        searchTextField.textColor = WDTextBlack
        searchTextField.attributedPlaceholder = NSAttributedString.init(string: "Search a word", attributes: placeholderAttributes)
        searchTextField.delegate = self
        searchTextField.returnKeyType = .done
        searchTextField.clearButtonMode = .always
        view.addSubview(searchTextField)
        searchTextField.becomeFirstResponder()
        searchTextField.resignFirstResponder()
        textFieldSeparator.frame = CGRect(x: 0, y: searchTextField.frame.height - 1, width: searchTextField.frame.width - kSidePadding, height: 1)
        searchTextField.addSubview(textFieldSeparator)
        
    }
    
    
    fileprivate func createDottedLoader() {
        dottedLoader.backgroundColor = UIColor.white
        dottedLoader.alpha = 0
        view.addSubview(dottedLoader)
    }
    
    func transitionToSearchState(keyboardHeight:CGFloat) {
        if self.searchTableView.alpha == 0 {
            searchTableView.contentOffset = CGPoint(x: 0, y: -searchTableView.contentInset.top)
        }
        let tableY = kStatusBarHeight + kTextFieldHeight + 3*kDefaultPadding
        
        UIView.animate(withDuration: 0.17, animations: {
            self.searchTextField.frame = CGRect(x: self.searchTextField.frame.origin.x, y: kStatusBarHeight + kDefaultPadding, width: (self.view.frame.size.width - 2*kSidePadding) - 2*kDefaultPadding - kDottedLoaderWidth, height: self.searchTextField.frame.height)
            self.dottedLoader.frame = CGRect(x: self.searchTextField.frame.origin.x + self.searchTextField.frame.width + kDefaultPadding, y: self.searchTextField.frame.origin.y + self.searchTextField.frame.height/2 - kDottedLoaderHeight/2, width: kDottedLoaderWidth, height: kDottedLoaderHeight)
            
        }) { (finished) in
            
            UIView.animate(withDuration: 0.15, animations: {
                self.searchTableView.frame = CGRect(x: 0, y: tableY, width: self.view.frame.width , height: self.view.frame.height - tableY - keyboardHeight)
                self.searchTableView.alpha = 1
            })
        }
        
    }
    
    func transitionToDefaultState() {
        if searchTextField.text?.isEmpty == true {
            self.searchTableView.alpha = 0.0
            let searchFieldOriginY = (self.view.frame.size.height - kTextFieldHeight)/2 - 20
            
            UIView.animate(withDuration: 0.2) {
                self.searchTextField.frame = CGRect(x: kSidePadding, y: searchFieldOriginY, width: self.view.frame.size.width - 2*kSidePadding, height: self.searchTextField.frame.height)
                self.searchTableView.alpha = 0.0
            }
        }
    }
    
    @objc func didTapSearchBackground() {
        if searchTextField.isFirstResponder && searchTextField.text?.isEmpty == true {
            searchTextField.resignFirstResponder()
        }
    }
    
    @objc func willShowKeyboard(notification:NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            transitionToSearchState(keyboardHeight: keyboardHeight)
        }

    }
    
    @objc func willHideKeyboard() {
            transitionToDefaultState()
    }
    
    func clearResults() {
        hideDottedLoader()
        wordSearchObject.clearSearch()
        searchTableView.reloadData()
    }
    
    func showDottedLoader() {
        if dottedLoader.alpha == 0 {
            UIView.animate(withDuration: 0.2, animations: {
                self.dottedLoader.alpha = 1
            }, completion: { (finished) in
                self.dottedLoader.startAnimating()
            })
        }
    }
    
    func hideDottedLoader() {
        dottedLoader.stopAnimating()
        UIView.animate(withDuration: 0.2) {
            self.dottedLoader.alpha = 0
        }
    }
    
}

extension WDSearchViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingText = textField.text! as NSString
        let updatedText = existingText.replacingCharacters(in: range, with: string)
        if updatedText.count > 1 {
            wordSearchObject.performSearch(withQuery: updatedText, delegate: self)
            showDottedLoader()
        }
        else {
            clearResults()
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        clearResults()
        return true
    }
}

extension WDSearchViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSearchResultReuseIdentifer)!
        
        if let cell = cell as? WDSearchResultTableViewCell {
            cell.setTitle(wordSearchObject.searchResults[indexPath.row].word)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordSearchObject.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        view.endEditing(true)
        let wordDetailVC = WDWordDetailViewController.init(withWord: wordSearchObject.searchResults[indexPath.row])
        wordDetailVC.shouldShowAddButton = true
        self.navigationController?.pushViewController(wordDetailVC, animated: true)
    }
}

extension WDSearchViewController:WordSearchDelegate {
    func didPerformSearchSuccessfully(forQuery query: String) {
        searchTableView.reloadData()
        hideDottedLoader()
    }
    
    func didFailToSearch(query: String) {
        searchTableView.reloadData()
        hideDottedLoader()
    }
    
    
}

