//
//  HorizontalCollectionViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 16.02.2023.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    static let identifier = "HorizontalCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "HorizontalCollectionViewCell", bundle: nil)
    }

}
