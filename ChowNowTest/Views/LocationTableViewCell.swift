//
//  LocationTableViewCell.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var distanceLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let nameLabel = nameLabel {
            nameLabel.font = UIFont.cn_mediumFont(size: 18.0)
            nameLabel.textColor = UIColor.cn_squidInk()
        }
        if let distanceLabel = distanceLabel {
            distanceLabel.font = UIFont.cn_normalFont(size: 12.0)
            distanceLabel.textColor = UIColor.cn_squidInk()
        }
        distanceLabel?.text = nil
    }
    
    var location: CNLocation? {
        didSet {
            if let location = location {
                nameLabel?.text = location.shortName
            }
        }
    }
    
    var distanceInMiles: Double? {
        didSet {
            if let distance = distanceInMiles {
                if distance == 0 {
                    distanceLabel?.isHidden = true
                } else {
                    distanceLabel?.isHidden = false
                    distanceLabel?.text = String(format: "%.1f MILES", distance * 0.00062137)
                }
            }
        }
    }
}
