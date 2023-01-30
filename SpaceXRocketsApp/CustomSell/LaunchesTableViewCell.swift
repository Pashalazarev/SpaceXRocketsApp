//
//  LaunchesTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 22.01.2023.
//

import UIKit

private enum LaunchImages {
    static let success = "success launch"
    static let failed = "failed launch"
}

final class LaunchesTableViewCell: UITableViewCell {
    
    @IBOutlet private var launcheNameLable: UILabel!
    @IBOutlet private var dateOfLaunchLabel: UILabel!
    
    @IBOutlet var launchImage: UIImageView!
    
    // MARK: - Configuration method for cell
    
    func configure(launches: Launch, date: String) {
        launcheNameLable.text = launches.name
        dateOfLaunchLabel.text = date
        if launches.success == true {
            launchImage.image = UIImage.init(named: LaunchImages.success)
        } else if launches.success == false {
            launchImage.image = UIImage.init(named: LaunchImages.failed)
        }
    }
}
