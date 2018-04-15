//
//  Restaurant.swift
//  ChowNowTest
//
//  Created by Ngoan Nguyen on 4/14/18.
//  Copyright © 2018 Ngoan Nguyen. All rights reserved.
//

import UIKit

struct CNRestaurant: Codable {
    let name: String
    let locations: [CNLocation]
    let phone: String
    let identifier: String
    let address: CNAddress
    
    enum CodingKeys: String, CodingKey {
        case name
        case locations
        case phone
        case identifier = "id"
        case address
    }
}
