//
//  SettingsTableViewController.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 10.01.2023.
//

import UIKit

final class SettingsTableViewController: UITableViewController {
    
    private let availableSettings = Settings.availableSettings()
    private let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.lightText]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        availableSettings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath) as! SettingsTableViewCell
        let settings = availableSettings[indexPath.row]
        cell.settingsTypeLabel.text = settings.type.rawValue
      
        cell.segmentedControl.setTitle(settings.unit.first?.rawValue, forSegmentAt: 0)
        cell.segmentedControl.setTitle(settings.unit.last?.rawValue, forSegmentAt: 1)
        
        cell.onSettingsChanged = { selectedIndex in
            UserDefaults.standard.set(selectedIndex, forKey: settings.type.rawValue)
        }
    
        cell.segmentedControl.selectedSegmentIndex =
            UserDefaults.standard.integer(forKey: settings.type.rawValue)

        return cell
    }
}
