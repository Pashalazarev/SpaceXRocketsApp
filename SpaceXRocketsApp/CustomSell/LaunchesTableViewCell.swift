//
//  LaunchesTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 22.01.2023.

import UIKit

final class LaunchesTableViewCell: UITableViewCell {
    
    @IBOutlet private var viewForCell: UIView!
    @IBOutlet private var launcheNameLable: UILabel!
    @IBOutlet private var dateOfLaunchLabel: UILabel!
    
    @IBOutlet private var launchImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewForCell.backgroundColor = UIColor.init(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
    }
    
    // MARK: - Configuration method for cell
    
    func configure(launches: Launch, date: String, typeOfLaunch: UIImage) {
        launcheNameLable.text = launches.name
        dateOfLaunchLabel.text = date
        launchImage.image = typeOfLaunch
    }
}
