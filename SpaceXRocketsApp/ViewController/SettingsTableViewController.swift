//
//  SettingsTableViewController.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 10.01.2023.
//

import UIKit

final class SettingsTableViewController: UITableViewController {
   
    private let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.lightText]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Settings.availableSettings().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath) as? SettingsTableViewCell
        else {
            return UITableViewCell()
        }
        let settings = Settings.availableSettings()[indexPath.row]
        cell.configure(settings: settings)
        return cell
    }
}
