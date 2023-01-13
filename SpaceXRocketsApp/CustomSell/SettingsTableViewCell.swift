//
//  SettingsTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 10.01.2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    let settingsTableVC = SettingsTableViewController()
    
    @IBOutlet var settingsTypeLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func settingsUnitAction() {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
