//
//  ButtonCollectionViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 16.02.2023.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {

    @IBOutlet var showLaunchesButton: UIButton!
    
    static let identifier = "ButtonCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    @IBAction func showLaunchesButtonPressed() {
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "ButtonCollectionViewCell", bundle: nil)
    }
    
}
