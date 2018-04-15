//
//  RestaurantLocation.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit

class CNLocation: Codable {
    let name: String
    let shortName: String
    let address: CNAddress
    let identifier: String
    let phone: String
    var distance: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case name
        case shortName = "short_name"
        case phone = "phone"
        case identifier = "id"
        case address = "address"
    }
    
    func updateDistance(_ distance: Double) {
        self.distance = distance
    }
}
