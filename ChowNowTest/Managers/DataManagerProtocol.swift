//
//  DataManagerProtocol.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit
import CoreLocation

protocol DataManagerProtocol {
    func fetchRestaurant(completion: @escaping (_ result: CNRestaurant?, _ error: String?) -> Void)
}
