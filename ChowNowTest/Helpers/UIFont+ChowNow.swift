//
//  UIColor+ChowNow.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit

extension UIFont {
    class func cn_normalFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir", size: size)!
    }
    class func cn_mediumFont(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: size)!
    }
    class func cn_boldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size)!
    }
}
