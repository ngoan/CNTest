//
//  RestaurantSelectionCell.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit

class RestaurantSelectionCell: UICollectionViewCell {
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var gradientView: UIView?
    var gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel?.font = UIFont.cn_mediumFont(size: 18.0)
        gradientView?.backgroundColor = .clear
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ UIColor.clear.cgColor, UIColor(white: 0, alpha: 0.25).cgColor ]
        
        if let gradientView = gradientView {
            gradientView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    var restaurant: CNRestaurant? {
        didSet {
            if let restaurant = restaurant {
                nameLabel?.text = restaurant.name
                if let gradientView = gradientView {
                    setNeedsLayout()
                    layoutIfNeeded()
                    gradientLayer.frame = gradientView.bounds
                }
            }
        }
    }
}
