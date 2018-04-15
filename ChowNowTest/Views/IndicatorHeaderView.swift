//
//  IndicatorHeaderView.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/15/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit

class IndicatorHeaderView: UICollectionReusableView {
    
    private var indicatorView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        indicatorView = UIActivityIndicatorView()
        indicatorView.color = UIColor.cn_squidInk()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.startAnimating()
        addSubview(indicatorView)
        addConstraints([NSLayoutConstraint(item: indicatorView, attribute: .centerY, relatedBy: .equal,
                                           toItem: self, attribute: .centerY,
                                           multiplier: 1.0, constant: 0),
                        NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal,
                                           toItem: self, attribute: .centerX,
                                           multiplier: 1.0, constant: 0)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
