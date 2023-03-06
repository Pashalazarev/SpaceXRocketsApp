//
//  HeaderCollectionViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 15.02.2023.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var blackView: UIView!
    @IBOutlet var rocketImageView: UIImageView!
    @IBOutlet var rocketNameLabel: UILabel!
    
   static let identifier = "HeaderCollectionViewCell"
    
   override func awakeFromNib() {
       blackView.layer.cornerRadius = 20
       rocketImageView.layer.cornerRadius = 20
    }
    
    @IBAction func settingsButton(_ sender: UIButton) {
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "HeaderCollectionViewCell", bundle: nil)
    }
   
    
}
