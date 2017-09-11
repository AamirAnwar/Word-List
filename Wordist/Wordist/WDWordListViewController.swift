//
//  WDWordListViewController.swift
//  Wordist
//
//  Created by Aamir  on 10/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit

class WDWordListViewController: WDBaseViewController {
    
    var tableData = [String]()
    var nightModeSwitch: UISwitch?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headingLabel.text = "List"
        self.contentTableView.delegate = self
        self.contentTableView.dataSource = self
        self.contentTableView.register(UITableViewCell.self, forCellReuseIdentifier: SettingsCellReuseIdentifier)
        createTableData()
    }
    
    func createTableData() {
        //TODO
        //self.tableData += ["Night Mode", "Licences", "About"]
    }
}

extension WDWordListViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
