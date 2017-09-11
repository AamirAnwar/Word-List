//
//  WDWordListViewController.swift
//  Wordist
//
//  Created by Aamir  on 10/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit

let WordListCellReuseIdentifier = "WordListCellReuseIdentifier"
class WDWordListViewController: WDBaseViewController {
    
    var tableData = [WordObject]()
    var nightModeSwitch: UISwitch?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: Notification.Name(NotificationDidSaveWord), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: Notification.Name(NotificationDidRemoveWord), object: nil)
        
        self.headingLabel.text = "List"
        self.navigationItem.title = "List"
        self.contentTableView.delegate = self
        self.contentTableView.dataSource = self
        self.contentTableView.rowHeight = 78
        self.contentTableView.register(UITableViewCell.self, forCellReuseIdentifier: WordListCellReuseIdentifier)
        self.tableData = WDWordListManager.sharedInstance.getWords()
    }
    
    
    @objc func refreshTableView() {
        tableData = WDWordListManager.sharedInstance.getWords()
        self.contentTableView.reloadData()
    }
        
}

extension WDWordListViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordListCellReuseIdentifier)
        cell?.textLabel?.text = tableData[indexPath.row].word
        cell?.textLabel?.font = WDFontTitleMedium
        cell?.tintColor = WDMainTheme
        cell?.accessoryType = .disclosureIndicator
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let wordDetailVC = WDWordDetailViewController.init(withWord: tableData[indexPath.row])
        wordDetailVC.shouldShowAddButton = true
        wordDetailVC.delegate = self
        self.navigationController?.pushViewController(wordDetailVC, animated: true)
    }
}

extension WDWordListViewController:WDWordDetailViewControllerDelegate {
    func didSaveWord(wordInstance: WordObject) {
        refreshTableView()
        
    }
    
    func didRemoveWord(wordInstance: WordObject) {
        refreshTableView()
    }
}
