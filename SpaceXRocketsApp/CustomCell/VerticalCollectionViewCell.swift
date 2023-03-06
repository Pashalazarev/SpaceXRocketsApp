//
//  VerticalCollectionViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 16.02.2023.
//

import UIKit

class VerticalCollectionViewCell: UICollectionViewCell {

    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    
    static let identifier = "VerticalCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "VerticalCollectionViewCell", bundle: nil)
    }
    
    
}
