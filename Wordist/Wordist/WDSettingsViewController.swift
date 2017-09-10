//
//  WDSettingsViewController.swift
//  Wordist
//
//  Created by Aamir  on 10/09/17.
//  Copyright © 2017 AamirAnwar. All rights reserved.
//

import UIKit
let SettingsCellReuseIdentifier = "SettingsCellReuseIdentifier"
class WDSettingsViewController: WDBaseViewController {
    var tableData = [String]()
    var nightModeSwitch: UISwitch?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headingLabel.text = "Settings"
        self.contentTableView.delegate = self
        self.contentTableView.dataSource = self
        self.contentTableView.rowHeight = 78
        self.contentTableView.separatorColor = WDSeparatorGray
        self.contentTableView.register(UITableViewCell.self, forCellReuseIdentifier: SettingsCellReuseIdentifier)
        createTableData()
    }
    
    func createTableData() {
        self.tableData += ["Night Mode", "Licences", "About"]
    }
}


extension WDSettingsViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCellReuseIdentifier)
        cell?.textLabel?.font = WDFontBigBodyText
        cell?.textLabel?.text = tableData[indexPath.row]
        if indexPath.row == 0 {
            nightModeSwitch = UISwitch()
            nightModeSwitch?.onTintColor = WDMainTheme
            cell?.selectionStyle = .none
            cell?.accessoryView = nightModeSwitch
        }
        else {
            cell?.tintColor = WDMainTheme
            cell?.accessoryType = .disclosureIndicator
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
